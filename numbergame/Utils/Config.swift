//
//  Config.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import Foundation

class Config {
    enum Keys {
        static let api_url = "API_URL"
        static let api_key = "API_KEY"
    }
    
    private static func getValue(key: String) -> String {
        guard let value = Config.infoDictionary[key] as? String else {
            fatalError("Could not get value for key: \(key)")
        }
        return value
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            fatalError("Could not get info dictionary")
        }
        return infoDictionary
    }()
    
    static let apiURL: String = getValue(key: Keys.api_url)
    static let apiKey: String = getValue(key: Keys.api_key)
}
