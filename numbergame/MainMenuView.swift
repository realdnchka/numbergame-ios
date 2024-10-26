//
//  MainMenuView.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import SwiftUI

struct MainMenu: View {
    private let menuItems: [String] = ["NEW GAME", "LEADERBOARD", "PROFILE", "SETTINGS"]
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
                        Spacer()
                        Loader(size: 96, duration: 10)
                        Spacer()
                        MenuButton(text: menuItems[0], destination: GameView(numbers: numbers, sum: numbers?.sum))
                        MenuButton(text: menuItems[1], destination: LeaderboardView())
                        MenuButton(text: menuItems[2], destination: UserProfile())
                        MenuButton(text: menuItems[3], isDisabled: true, destination: MainMenu())
                        Spacer()
                        Spacer()
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
