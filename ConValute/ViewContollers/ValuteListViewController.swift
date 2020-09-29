//
//  ValuteListViewController.swift
//  ConValute
//
//  Created by Сергей Шестаков on 21.09.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import UIKit

class ValuteListViewController: UIViewController {

    // MARK: - Subviews
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectTextLabel: UILabel!
    @IBOutlet weak var selectValuteTextField: UITextField!
    @IBOutlet weak var rubTextField: UITextField!
    @IBOutlet weak var valuteTableView: UITableView!
    
    // MARK: - Private object
    private var nameValute = [String]()
    private var valuteValue = 0.0
    private var valuteNominal = 0
    private let nameSelectTextLabel = "Valute"
    private let messegeNoSelectedValute = "Select currency"
    
    // MARK: - Actions
    @IBAction func tap(_ sender: Any) {
        hiddenKeyboard()
    }
    @IBAction func editingDidBeginRUB(_ sender: Any) {
        if rubTextField.text == messegeNoSelectedValute {
            rubTextField.text = .none
        }
    }
    @IBAction func updateCourseValute(_ sender: Any) {
        loadValuteList()
        titleLabel.text = "Updated"
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.titleLabel.text = "Conversion"
        })
    }
    @IBAction func changeRUB(_ sender: Any) {
        convertValute()
        if selectTextLabel.text == nameSelectTextLabel {
            selectValuteTextField.text = messegeNoSelectedValute
        }
    }
    @IBAction func changeSelectValute(_ sender: Any) {
        convertValuteToRUB()
        if selectTextLabel.text == nameSelectTextLabel {
            rubTextField.text = messegeNoSelectedValute
        }
    }

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        loadValuteList()
        configurateTableView()
        self.valuteTableView.dataSource = self
        self.valuteTableView.delegate = self
    }
    
    // MARK: - Private method
    private func configurateTableView() {
        valuteTableView.layer.cornerRadius = 20
    }
    private func hiddenKeyboard() {
        rubTextField.resignFirstResponder()
        selectValuteTextField.resignFirstResponder()
    }
    private func loadValuteList() {
        getResults(from: allValute()!) {
            DispatchQueue.main.async {
                self.nameValute = feedValute.keys.sorted()
                self.valuteTableView.reloadData()
            }
        }
    }
    private func convertValute() {
        if let cost = Double(rubTextField.text!) {
            let convert = round(cost / (valuteValue / Double(valuteNominal)) * 100) / 100
            selectValuteTextField.text = String(convert)
        } else {
            selectValuteTextField.text = .none
        }
    }
    private func convertValuteToRUB() {
        if let cost = Double(selectValuteTextField.text!) {
            let convert = round(cost * (valuteValue / Double(valuteNominal)) * 100) / 100
            rubTextField.text = String(convert)
        } else {
            rubTextField.text = .none
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ValuteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameValute.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        }
        let valuteValueText = feedValute["\(nameValute[indexPath.row])"]?.Value
        cell?.textLabel?.text = nameValute[indexPath.row] + " " + String(valuteValueText!)
        cell?.detailTextLabel?.text = feedValute["\(nameValute[indexPath.row])"]?.Name ?? ""
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectTextLabel.text = nameValute[indexPath.row]
        valuteValue = feedValute["\(nameValute[indexPath.row])"]?.Value ?? 0.0
        valuteNominal = feedValute["\(nameValute[indexPath.row])"]?.Nominal ?? 0
        convertValute()
        hiddenKeyboard()
       }
}
