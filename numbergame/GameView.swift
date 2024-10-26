import SwiftUI

struct GameView: View {
    //Variables to control Numbers
    @State var numbers: Numbers?
    @State var currentSum: Int = 0
    @State var sum: Int?
    
    //Variables to controll animations
    @State var isPressedStates: [Bool] = Array(repeating: false, count: 5)
    @State var isNumbersLoading: Bool = false
    
    //Timer variables
    @StateObject var countdownTimer = CountdownTimer(duration: 60)
    
    //Score variables
    @State var score: Int = 0
    
    //Game Over popup
    @State var showGameOver = false
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    ZStack {
                        GameTimer(countdownTimer: countdownTimer)
                        HStack {
                            Spacer()
                            Spacer()
                            Score(scores: score)
                        }
                    }
                }
                
                Spacer()
                SumButton(sum: sum ?? 0)
                Spacer()
                
                if isNumbersLoading {
                    HStack {
                        ForEach(numbers?.numbers.indices ?? 0..<5, id: \.self) {
                            index in NumberButtonLoading(
                                isPressed: $isPressedStates[index]
                            )
                        }
                    }
                } else {
                    HStack {
                        ForEach(numbers?.numbers.indices ?? 0..<5, id: \.self) {
                            index in NumberButton(
                                currentSum: $currentSum,
                                isPressed: $isPressedStates[index],
                                text: numbers?.numbers[index].formatted() ?? "1"
                            )
                        }
                    }
                    .onChange(of: currentSum) {
                        if currentSum == sum {
                            Task {
                                score += Int.random(in: 80...110)
                                await newSetOfNumbers()
                            }
                        }
                    }
                    .onChange(of: countdownTimer.timeRemaining) {
                        if countdownTimer.timeRemaining == 0 {
                            showGameOver.toggle()
                            Task {
                                if try await userGetData().highscore < score {
                                    try await sendScore(score: score)
                                }
                            }
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .blur(radius: showGameOver ? 5 : 0)
            .disabled(showGameOver)
        }
        .overlay(
            Group {
                if showGameOver {
                    PopupGameOver()
                }
            })
        .onAppear() {
            Task {
                if sum == 0 {
                    await newSetOfNumbers()
                }
            }
        }
    }
    
    func newSetOfNumbers() async {
        isNumbersLoading = true
        numbers = await getNumbers(count: 5)
        isNumbersLoading = false
        currentSum = 0
        isPressedStates = Array(repeating: false, count: 5)
        sum = numbers?.sum ?? 0
    }
}

#Preview {
    GameView()
}
