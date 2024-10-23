//
//  NumberButton.swift
//  numbergame
//
//  Created by Danil Chernov on 21/10/24.
//

import SwiftUICore
import SwiftUI
import Combine

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
    @State var start = UnitPoint(x: -1, y: 0.5)
    @State var end = UnitPoint(x: 0, y: 0.5)
    
    var body: some View {
        Button(action: {}) {
            LinearGradient(gradient: Gradient(colors: [Color("ButtonLoadingStart"), Color("ButtonLoadingEnd"), Color("ButtonLoadingStart")]), startPoint: start, endPoint: end)
                .mask(RoundedRectangle(cornerRadius: 10))
                .frame(width: 64, height: 64)
                .onAppear() {
                    withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: false)) {
                        self.start = UnitPoint(x: 1, y: 0.5)
                        self.end = UnitPoint(x: 2, y: 0.5)
                    }
                }
        }
        .disabled(true)
        .buttonStyle(LoadingButtonStyle())
    }
}

#Preview {
    NumberButtonLoading()
}
