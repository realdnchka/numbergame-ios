//
//  LoginView.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct LoginView: View {
    @State var numbers: Numbers?
    //Loader variables
    @State var showLoader: Bool = true
    
    //Login variables
    @State var usernameInput: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                if showLoader {
                    Loader()
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $isLoggedIn) {
                MainMenu(numbers: numbers)
            }
        }
        .onAppear() {
            Task {
                if isUserRegistred() {
                    isLoggedIn = try! await loginUser(username: UserDefaults.standard.string(forKey: "username")!, token: UserDefaults.standard.string(forKey: "token")!)
                } else {
                    isLoggedIn = false
                }
                showLoader = false
            }
        }
        .onDisappear() {
            Task {
                numbers = await getNumbers()
            }
        }
        .overlay(
            Group {
                if !showLoader && !isLoggedIn {
                    PopupRegistration(isLoggedIn: $isLoggedIn, showLoader: $showLoader)
                }
            })
    }
}
