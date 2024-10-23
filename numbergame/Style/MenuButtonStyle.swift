//
//  MenuButtonStyle.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import SwiftUI

struct MenuButtonStyle: ButtonStyle {
    let buttonColor: Color = Color("Button")
    let fontColor: Color = Color("FontButton")
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width:256, height: 52)
            .font(.system(size: 32))
            .foregroundColor(fontColor)
            .background(buttonColor)
            .cornerRadius(15)
            .shadow(radius: 2)
        }
}

struct MenuButtonPressedStyle: ButtonStyle {
    let buttonColor: Color = Color("ButtonPressed")
    let fontColor: Color = Color("FontButtonPressed")
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .frame(width:256, height: 52)
            .font(.system(size: 32))
            .foregroundColor(fontColor)
            .background(buttonColor)
            .cornerRadius(15)
            .shadow(radius: 2)
        }
}