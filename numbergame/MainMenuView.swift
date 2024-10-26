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
    @State private var size = 256.0
    @State var rotationAngle = 0.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea(.all)
                if numbers == nil {
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
                        Image(.loaderIcon)
                            .resizable()
                            .frame(width: size, height: size)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 2)
                                    .repeatForever(autoreverses: true)) {
                                        size += 16
                                    }
                            }
                            .padding()
                        MenuButton(text: menuItems[0], destination: GameView(numbers: numbers, sum: numbers?.sum))
                        MenuButton(text: menuItems[1], isDisabled: true, destination: MainMenu())
                        MenuButton(text: menuItems[2], isDisabled: true, destination: MainMenu())
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
