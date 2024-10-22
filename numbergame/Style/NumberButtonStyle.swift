//
//  NumberButtonStyle.swift
//  numbergame
//
//  Created by Danil Chernov on 21/10/24.
//

import SwiftUI

struct PressedButtonStyle: ButtonStyle {
    let buttonColor: Color = Color("ButtonPressed")
    let fontColor: Color = Color("FontButtonPressed")
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width:64, height: 64)
            .font(.system(size: 42))
            .foregroundColor(fontColor)
            .background(buttonColor)
            .cornerRadius(10)
            .shadow(radius: 2)
            .animation(.easeInOut, value: 1)
        }
}

struct UnPressedButtonStyle: ButtonStyle {
    let buttonColor: Color = Color("Button")
    let fontColor: Color = Color("FontButton")
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width:64, height: 64)
            .font(.system(size: 42))
            .foregroundColor(fontColor)
            .background(buttonColor)
            .cornerRadius(10)
            .shadow(radius: 2)
            .animation(.easeInOut, value: 1)
        }
}

struct AnyButtonStyle: ButtonStyle {
    private let makeBody: (Configuration) -> AnyView

    init<S: ButtonStyle>(_ style: S) {
        makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        makeBody(configuration)
    }
}
