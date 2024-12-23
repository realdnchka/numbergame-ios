//
//  PopUp.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct PopUp<Content: View>: View {
    let content: Content
    var width: CGFloat = 240
    //    var height: CGFloat = 240
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            content
        }
        .frame(width: width)
        .cornerRadius(10.0)
        .shadow(radius: 20.0)
    }
}

struct PopupGameOver: View {
    let menuItems: [String] = ["NEW GAME", "WATCH AD", "EXIT TO MENU"]
    @State var numbers: Numbers?
    var body: some View {
        PopUp {
            NavigationView {
                ZStack {
                    Color("Background")
                    VStack {
                        Text("Time over!")
                        MenuButton(text: menuItems[0], destination: GameView(numbers: numbers, sum: numbers?.sum)).task {
                            numbers = await getNumbers()
                        }
                        MenuButton(text: menuItems[1], isDisabled: true, destination: MainMenu())
                        MenuButton(text: menuItems[2], destination: MainMenu())
                    }
                }
            }
        }
        .frame(height: 240)
    }
}

struct PopupRegistration: View {
    @Binding var isLoggedIn: Bool
    @Binding var showLoader: Bool
    @State var usernameInput: String = ""
    
    var body: some View {
        PopUp {
            ZStack {
                VStack {
                    //                    TextField("Username:", text: $usernameInput)
                    //                        .multilineTextAlignment(.center)
                    //                        .padding(12)
                    //                        .background(Color("ButtonPressed"))
                    //                        .foregroundColor(Color("FontButtonPressed"))
                    //                        .cornerRadius(15.0)
                    //                        .frame(width: 192)
                    //                        .font(.system(size: 18, weight: .bold))
                    //                        .autocapitalization(.none)
                    ZStack {
                        TextField("", text: $usernameInput)
                            .multilineTextAlignment(.center)
                            .frame(width: 192, height: 48)
                            .background(Color("InputBackground"))
                            .foregroundColor(Color("FontButtonPressed"))
                            .cornerRadius(15.0)
                            .font(.system(size: 22, weight: .bold))
                            .autocapitalization(.none)
                        Text("Enter your username:")
                            .font(.system(size: 12, weight: .medium))
                        //                            .foregroundColor(Color("InputText"))
                            .offset(x: -32, y: -24)
                    }
                    .frame(width: 192)
                    
                    Button("REGISTER") {
                        Task {
                            showLoader = true
                            try await registerUser(username: usernameInput)
                            isLoggedIn = true
                            showLoader = false
                        }
                    }
                    .buttonStyle(MenuButtonStyle())
                }
            }
        }
        .frame(height: 160)
    }
}

#Preview {
    PopupRegistration(isLoggedIn: .constant(false), showLoader: .constant(false))
}
