//
//  GameTimer.swift
//  numbergame
//
//  Created by Danil Chernov on 25/10/24.
//

import SwiftUICore
import Combine

class CountdownTimer: ObservableObject {
    @Published var timeRemaining: Int
    private var timer: AnyCancellable?
    
    init(duration: Int) {
        self.timeRemaining = duration
    }
    
    func start() {
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stop()
                }
            }
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
    
    func addTime(seconds: Int) {
        timeRemaining += seconds
    }
}

struct GameTimer: View {
    @ObservedObject var countdownTimer: CountdownTimer
    
    var body: some View {
        Text("\(countdownTimer.timeRemaining)")
            .onAppear() {
                countdownTimer.start()
            }
    }
}
