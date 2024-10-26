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
