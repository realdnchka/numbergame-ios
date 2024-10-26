//
//  LeaderboardView.swift
//  numbergame
//
//  Created by Danil Chernov on 26/10/24.
//

import SwiftUI

struct LeaderboardView: View {
    @State var leaderboard: [LeaderboardEndtry]?
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea(.all)
            if isLoading {
                Loader()
            } else {
                VStack{
                    ForEach(leaderboard ?? []) { entry in
                        HStack {
                            Text(entry.username)
                            Score(scores: entry.highscore)
                        }
                    }
                }
            }
        }
        .onAppear() {
            Task {
                leaderboard = try await getLeaderboard()
                isLoading = false
            }
        }
    }
}

#Preview {
    LeaderboardView()
}
