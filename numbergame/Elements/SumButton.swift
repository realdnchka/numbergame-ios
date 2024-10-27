//
//  SumButton.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct SumButton: View {
    var sum: Int = 0
    
    var body: some View {
        ZStack {
            Image("SumButton")
                .frame(width:64, height: 64)
                .shadow(radius: 2)
            
            Text("\(sum)")
                .font(.system(size: 38))
                .fontWeight(.medium)
                .foregroundColor(Color("FontButtonPressed"))
        }
    }
}

#Preview {
    SumButton()
}

struct SumButtonLoading: View {
    @State var start = UnitPoint(x: -1, y: 0.5)
    @State var end = UnitPoint(x: 0, y: 0.5)
    
    var body: some View {
        let startColor: Color = Color("ButtonLoadingStart")
        let endColor: Color = Color("ButtonLoadingEnd")
        
        Image("SumButton")
            .shadow(radius: 2)
            .overlay(
                LinearGradient(gradient: Gradient(colors: [startColor, endColor, endColor, startColor]), startPoint: start, endPoint: end)
                    .mask(
                        Image("SumButton")
                    )
                    .onAppear() {
                        withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: false)) {
                            self.start = UnitPoint(x: 1, y: 0.5)
                            self.end = UnitPoint(x: 2, y: 0.5)
                        }
                    }
            )
    }
}
