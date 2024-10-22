//
//  NumberButton.swift
//  numbergame
//
//  Created by Danil Chernov on 21/10/24.
//

import SwiftUICore
import SwiftUI

struct NumberButton: View {
    @Binding var currentSum: Int
    @Binding var isPressed: Bool
    
    var text: String
    
    var body: some View {
        let number = Int(text)!
        
        Button {
            if isPressed {
                if currentSum != 0 {
                    isPressed.toggle()
                    currentSum -= number
                }
            } else {
                isPressed.toggle()
                currentSum += number
            }
        } label: {
            Text(text)
        }
        .buttonStyle(isPressed ? AnyButtonStyle(PressedButtonStyle()) : AnyButtonStyle(UnPressedButtonStyle()))
        .disabled(false)
    }
}

struct NumberButtonLoading: View {
    var body: some View {
        Button(action: {}) {
            ProgressView()
                .tint(Color("FontButton"))
        }
        .buttonStyle(UnPressedButtonStyle())
        .disabled(true)
        .font(.system(size: 100))
    }
}
