//
//  ViewController.swift
//  ConValute
//
//  Created by Сергей Шестаков on 21.09.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
           let ValuteVC = storyboard?.instantiateViewController(identifier: "ValuteListViewController") as! ValuteListViewController
        self.navigationController?.pushViewController(ValuteVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
          navigationController?.setNavigationBarHidden(true, animated: true)
      }
}

