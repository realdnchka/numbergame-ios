//
//  LoginView.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct LoginView: View {
    @State var numbers: Numbers?
    //Animation and Loader variables
    @State private var rotationAngle = 0.0
    @State var showLoader: Bool = true
    @State private var size = 256.0
    
    //Login variables
    @State var usernameInput: String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                if showLoader {
                    Image(.loaderIcon)
                        .resizable()
                        .blur(radius: 1)
                        .frame(width: size, height: size)
                        .rotationEffect(.degrees(rotationAngle))
                        .onAppear {
                            withAnimation(.linear(duration: 2)
                                .repeatForever(autoreverses: false)) {
                                    rotationAngle = 360.0
                                }
                        }
                } else {
                    VStack {
                        if !isLoggedIn{
                            VStack {
                                TextField("Your username:", text: $usernameInput)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                
                                Button("Register") {
                                    Task {
                                        showLoader = true
                                        try await registerUser(username: usernameInput)
                                        isLoggedIn = true
                                        showLoader = false
                                    }
                                }
                                .buttonStyle(DefaultButtonStyle())
                                .padding()
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $isLoggedIn) {
                            MainMenu()
                        }
        }
        .onAppear() {
            Task {
                let defaults = UserDefaults.standard
                print(defaults.dictionaryRepresentation())
                
                if isUserRegistred() {
                    isLoggedIn = try! await loginUser(username: UserDefaults.standard.string(forKey: "username")!, token: UserDefaults.standard.string(forKey: "token")!)
                } else {
                    isLoggedIn = false
                }
                showLoader = false
            }
        }
    }
}
