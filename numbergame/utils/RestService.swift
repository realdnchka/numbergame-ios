//
//  RestService.swift
//  numbergame
//
//  Created by Danil Chernov on 13/10/24.
//

import Foundation

func getNumbers() async throws -> Numbers {
//    let url = URL(string: loadConfig()!.url)!
    let url = URL(string: "http://localhost:80/getNumbers")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let numbers = try JSONDecoder().decode(Numbers.self, from: data)
    return numbers
}
