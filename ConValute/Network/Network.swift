//
//  Network.swift
//  ConValute
//
//  Created by Сергей Шестаков on 21.09.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation
//MARK: - URL
var everythingValuteUrl = URLComponents(string: "https://www.cbr-xml-daily.ru/daily_json.js")
//MARK: - Funcion of get URL
func allValute() -> URL? {
    return everythingValuteUrl?.url
}
//MARK: - Object
var feedValute: [String: Valutes] = [:]
var errorMessage = ""
let decoder = JSONDecoder()

//MARK: - Network
func getResults(from url: URL, completion: @escaping () -> ()) {
    URLSession.shared.dataTask(with: url) { (data, response, error ) in
        guard let data = data else { return }
        updateResults(data)
        completion()
        }.resume()
}
fileprivate func updateResults(_ data: Data) {
    decoder.dateDecodingStrategy = .iso8601
    do {
        let rawFeed = try decoder.decode(Currency.self, from: data)
        feedValute = rawFeed.Valute
    } catch let decodeError as NSError {
        errorMessage += "Decoder error: \(decodeError.localizedDescription)"
        print(errorMessage)
        return
    }
}
