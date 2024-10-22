//
//  Config.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import Foundation

class Config {
    static let shared = Config()
    private var configData: ConfigData?
    var url: URL = URL(string: "http://localhost:80/")! 
    
    private init() {
        configData = readConfig()
        url = URL(string: configData?.url ?? "http://localhost:80/")!
    }
    
    private func readConfig() -> ConfigData? {
        guard let file = Bundle.main.url(forResource: "config", withExtension: "json")
        else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(ConfigData.self, from: Data(contentsOf: file))
        } catch {
            return nil
        }
    }
}

struct ConfigData: Decodable {
    let url: String
}
