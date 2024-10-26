//
//  MainMenuView.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import SwiftUI

struct MainMenu: View {
    private let menuItems: [String] = ["New Game", "Leaderboard", "Profile", "Settings"]
    @State var numbers: Numbers?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                if numbers == nil {
                    Loader()
                } else {
                    VStack {
                        Loader(size: 64, duration: 10)
                        MenuButton(text: menuItems[0], destination: GameView(numbers: numbers, sum: numbers?.sum))
                        MenuButton(text: menuItems[1], isDisabled: true, destination: MainMenu())
                        MenuButton(text: menuItems[2], destination: UserProfile())
                        MenuButton(text: menuItems[3], isDisabled: true, destination: MainMenu())
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear() {
            Task {
                numbers = await getNumbers()
            }
        }
        
    }
}

#Preview {
    MainMenu()
}
