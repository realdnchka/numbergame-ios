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
    @State var isButtonPressed: Bool = false
    @State private var rotationAngle = -0.1
    @State private var size = 128.0
    @State private var blur = 1.0
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                if (numbers == nil && rotationAngle != 0) {
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
                }
                else {
                    VStack {
                        Image(.loaderIcon)
                            .resizable()
                            .frame(width: size, height: size)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 2)
                                    .repeatForever(autoreverses: true)) {
                                        rotationAngle = 360.0
                                        size += 16
                                    }
                            }
                        Divider()
                        MenuButton2(text: menuItems[0], destination: GameView(numbers: numbers, sum: numbers?.sum))
                        
                        MenuButton(text: menuItems[1], isDisabled: true,action: {})
                        MenuButton(text: menuItems[2], isDisabled: true,action: {})
                        MenuButton(text: menuItems[3], isDisabled: true,action: {})
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
