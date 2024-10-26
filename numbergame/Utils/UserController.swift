//
//  UserController.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import Foundation

func isUserRegistred() -> Bool {
    return UserDefaults.standard.string(forKey: "username") != nil ? true : false
}
