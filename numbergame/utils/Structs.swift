//
//  structs.swift
//  numbergame
//
//  Created by Danil Chernov on 13/10/24.
//

struct Numbers: Codable {
    let numbers: [Int]
    let sum: Int
}

struct Config: Codable {
    let url: String
}
