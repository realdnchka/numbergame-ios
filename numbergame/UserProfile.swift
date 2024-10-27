//
//  UserProfile.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct UserProfile: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                
                VStack {
                    Text("Username: \(UserDefaults.standard.string(forKey: "username") ?? "Unknown")")
                    HStack {
                        Text("Highest score: ")
                        Score(scores: Int(UserDefaults.standard.string(forKey: "highscore")!) ?? 0)
                    }
                }
            }
        }
    }
    
}


#Preview {
    MainMenu()
}
