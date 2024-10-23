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
        .buttonStyle(isPressed ? AnyButtonStyle(NumberButtonPressedStyle()) : AnyButtonStyle(NumberButtonStyle()))
        .disabled(false)
    }
}

struct NumberButtonLoading: View {
    @State var start = UnitPoint(x: -1, y: 0.5)
    @State var end = UnitPoint(x: 0, y: 0.5)
    @Binding var isPressed: Bool
    
    var body: some View {
        let startColor: Color = Color("ButtonLoadingStart")
        let endColor: Color = Color("ButtonLoadingEnd")
        
        Button(action: {}) {
            LinearGradient(gradient: Gradient(colors: [startColor, endColor, endColor, startColor]), startPoint: start, endPoint: end)
                .mask(RoundedRectangle(cornerRadius: 10))
                .frame(width: 64, height: 64)
                .onAppear() {
                    withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: false)) {
                        self.start = UnitPoint(x: 1, y: 0.5)
                        self.end = UnitPoint(x: 2, y: 0.5)
                    }
                }
        }
        .disabled(true)
        .buttonStyle(isPressed ? AnyButtonStyle(NumberButtonLoadingPressedStyle()) : AnyButtonStyle(NumberButtonLoadingStyle()))
    }
}

//#Preview {
//    NumberButtonLoading()
//}
