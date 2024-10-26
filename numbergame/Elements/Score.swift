//
//  Score.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct Score: View {
    var scores: Int = 0
    var body: some View {
        Text("\(scores)")
            .fontWeight(.medium)
            .font(.system(size: 22))
        Image(.score)
    }
}

#Preview {
    Score()
}
