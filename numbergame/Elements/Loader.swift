//
//  Loader.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct Loader: View {
    @State private var rotationAngle = 0.0
    @State var size = 256.0
    var duration = 4.0
    
    var body: some View {
        Image(.loaderIcon)
            .resizable()
            .frame(width: size, height: size)
            .rotationEffect(.degrees(rotationAngle))
            .onAppear {
                withAnimation(.linear(duration: duration)
                    .repeatForever(autoreverses: false)) {
                        rotationAngle = 360.0
                    }
            }
    }
}
