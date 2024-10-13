//
//  ContentView.swift
//  numbergame
//
//  Created by Danil Chernov on 12/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var numbers: Numbers?
    
    var body: some View {
        VStack {
            Text(numbers?.sum.formatted() ?? "99" )
            HStack {
                ForEach(numbers?.numbers ?? [1, 2, 3, 4, 5], id: \.self) { n in
                    Text(n.formatted())
                }
            }
        }
        .padding()
        .task {
            do {
                numbers = try await getNumbers()
            } catch {
                numbers = nil
            }
        }
    }
}

#Preview {
    ContentView()
}
