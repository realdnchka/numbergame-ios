//
//  MenuButton.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import SwiftUICore
import SwiftUI

//struct MenuButton: View {
//    var text: String
//    var isDisabled: Bool = false
//    var isPressed: Bool = false
//    var destination: AnyView
//    @State var showDestination: Bool = false
//    
//    var body: some View {
//        
//        Button(text) {
//            withAnimation(.easeInOut) {
//                showDestination.toggle()
//            }
//        }
//        .buttonStyle(isPressed || isDisabled ? AnyButtonStyle(MenuButtonPressedStyle()) : AnyButtonStyle(MenuButtonStyle()))
//        .disabled(isDisabled)
//        .animation(.easeInOut(duration: 0.2), value: isPressed)
//        .frame(width: 116, height: 32)
//        .cornerRadius(15.0)
//        .shadow(radius: 5.0)
//        
//        if showDestination {
//            destination
//                .transition(.opacity)
//        }
//    }
//}

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
        .frame(width: 116, height: 32)
        .cornerRadius(15.0)
        .shadow(radius: 5.0)
    }
}
