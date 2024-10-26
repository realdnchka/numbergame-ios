//
//  PopUp.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct PopUp<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color("Background")
            content
        }
        .frame(width: 240, height: 160)
        .cornerRadius(10.0)
        .shadow(radius: 20.0)
    }
}

struct PopupGameOver: View {
    let menuItems: [String] = ["New Game", "Watch Ad", "Exit to Menu"]
    @State var numbers: Numbers?
    var body: some View {
        PopUp {
            NavigationView {
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
}

struct PopupRegistration: View {
    @Binding var isLoggedIn: Bool
    @Binding var showLoader: Bool
    @State var usernameInput: String = ""
    
    var body: some View {
        PopUp {
            ZStack {
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
                    .buttonStyle(MenuButtonStyle())
                }
            }
        }
    }
}
