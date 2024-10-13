//
//  Config.swift
//  numbergame
//
//  Created by Danil Chernov on 13/10/24.
//

import Foundation

func loadConfig(path: String = "../config") -> Config? {
    let data = (try? Data(contentsOf: Bundle.main.url(forResource: path, withExtension: "json")!))!
    let config = try? JSONDecoder().decode(Config.self, from: data)
    return config
}
