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
    @State var isShowingMenu: Bool = false
    @State var isMenuDisabled = true
    @State var isButtonPressed: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                VStack {
                    Image(.mainMenuLogo)
                    MenuButton2(text: menuItems[0], isDisabled: isMenuDisabled, destination: GameView(numbers: numbers, sum: numbers?.sum))
                    
                    MenuButton(text: menuItems[1], isDisabled: true,action: {})
                    MenuButton(text: menuItems[2], isDisabled: true,action: {})
                    MenuButton(text: menuItems[3], isDisabled: true,action: {})
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear() {
            Task {
                numbers = await getNumbers()
                isMenuDisabled.toggle()
            }
        }
    }
}

#Preview {
    MainMenu()
}
