//
//  GameOver.swift
//  numbergame
//
//  Created by Danil Chernov on 25/10/24.
//

import SwiftUICore
import SwiftUI

struct GameOver: View {
    @Binding var isPresented: Bool
    private let menuItems: [String] = ["Start New Game", "Watch Ad", "Exit to Menu"]
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("Background")
                VStack {
                    Text("Time over!")
                    MenuButton(text: menuItems[0], destination: GameView())
                    MenuButton(text: menuItems[1], isDisabled: true, destination: MainMenu())
                    MenuButton(text: menuItems[2], destination: MainMenu())
                }
            }
        }
        .frame(width: 240, height: 160)
        .cornerRadius(10.0)
        .shadow(radius: 20.0)
    }
}
