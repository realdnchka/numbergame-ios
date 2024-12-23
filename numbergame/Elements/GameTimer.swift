//
//  GameTimer.swift
//  numbergame
//
//  Created by Danil Chernov on 25/10/24.
//

import SwiftUICore
import Combine

class CountdownTimer: ObservableObject {
    @Published var timeRemaining: Float
    private var timer: AnyCancellable?
    
    init(duration: Float) {
        self.timeRemaining = duration
    }
    
    func start() {
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 0.1
                } else {
                    self.stop()
                }
            }
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
    
    func addTime(seconds: Float) {
        timeRemaining += seconds
    }
}

struct GameTimer: View {
    @ObservedObject var countdownTimer: CountdownTimer
    
    var body: some View {
        Text("\(Int(countdownTimer.timeRemaining))")
            .onAppear() {
                countdownTimer.start()
            }
    }
}
