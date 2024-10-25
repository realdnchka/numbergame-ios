//
//  RestService.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import Foundation

func getNumbers(count: Int = 5) async -> Numbers {
    let url = URL(string: "\(Config.apiURL)/getNumbers?count=\(count)")!
    let (data, _) = try! await URLSession.shared.data(from: url)
    let numbers = try! JSONDecoder().decode(Numbers.self, from: data)
    return numbers
}

struct Numbers: Codable {
    let numbers: [Int]
    let sum: Int
}
