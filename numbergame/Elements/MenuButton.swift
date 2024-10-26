//
//  MenuButton.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import SwiftUI

struct MenuButton<Destination: View>: View {
    var text: String
    var isDisabled: Bool = false
    @State var isPressed: Bool = false
    var destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(text)
        }
        .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ _ in
                            withAnimation {
                                isPressed = true
                            }
                        })
                        .onEnded({ _ in
                            withAnimation {
                                isPressed = false
                            }
                        })
                )
        .buttonStyle(isPressed || isDisabled ? AnyButtonStyle(MenuButtonPressedStyle()) : AnyButtonStyle(MenuButtonStyle()))
        .disabled(isDisabled)
        .animation(.easeInOut(duration: 0.2), value: isPressed)
    }
}
