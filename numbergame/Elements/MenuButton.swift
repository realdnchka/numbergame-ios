//
//  MenuButton.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import SwiftUICore
import SwiftUI

struct MenuButton: View {
    var text: String
    var isDisabled: Bool = false
    var isPressed: Bool = false
    var action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            Text(text)
        }
        .buttonStyle(isPressed ? AnyButtonStyle(MenuButtonPressedStyle()) : AnyButtonStyle(MenuButtonStyle()))
        .disabled(isDisabled)
        .animation(.easeInOut(duration: 0.2), value: isPressed)
    }
}

struct MenuButton2<Destination: View>: View {
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
