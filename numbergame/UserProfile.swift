//
//  UserProfile.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct UserProfile: View {
    @State var isDataLoaded: Bool = false
    @State private var user: User?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                
                VStack {
                    if !isDataLoaded {
                        Loader()
                    } else {
                        Text("Username: \(UserDefaults.standard.string(forKey: "username") ?? "Unknown")")
                        Text("Highest score: \(user?.highscore ?? 0000)")
                    }
                }
            }
        }
        .onAppear() {
            Task {
                user = try await userGetData()
                isDataLoaded = true
            }
        }
        
    }
}

#Preview {
    MainMenu()
}
