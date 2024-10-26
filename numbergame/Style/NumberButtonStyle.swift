//
//  NumberButtonStyle.swift
//  numbergame
//
//  Created by Danil Chernov on 21/10/24.
//

import SwiftUI

struct NumberButtonPressedStyle: ButtonStyle {
    let buttonColor: Color = Color("ButtonPressed")
    let fontColor: Color = Color("FontButtonPressed")
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width:64, height: 64)
            .font(.system(size: 38))
            .fontWeight(.medium)
            .foregroundColor(fontColor)
            .background(buttonColor)
            .cornerRadius(10)
            .shadow(radius: 2)
            .animation(.easeInOut, value: 1)
        }
}

struct NumberButtonStyle: ButtonStyle {
    let buttonColor: Color = Color("Button")
    let fontColor: Color = Color("FontButton")
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width:64, height: 64)
            .font(.system(size: 38))
            .fontWeight(.medium)
            .foregroundColor(fontColor)
            .background(buttonColor)
            .cornerRadius(10)
            .shadow(radius: 2)
            .animation(.easeInOut, value: 1)
        }
}

struct NumberButtonLoadingStyle: ButtonStyle {
    let buttonColor: Color = Color("Button")
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width:64, height: 64)
            .font(.system(size: 42))
            .background(buttonColor)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
}

struct NumberButtonLoadingPressedStyle: ButtonStyle {
    let buttonColor: Color = Color("ButtonPressed")
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width:64, height: 64)
            .font(.system(size: 42))
            .background(buttonColor)
            .cornerRadius(10)
            .shadow(radius: 2)
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
