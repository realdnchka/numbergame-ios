import SwiftUI

struct GameView: View {
    @State var numbers: Numbers?
    @State var currentSum: Int = 0
    @State var sum: Int?
    @State var isPressedStates: [Bool] = Array(repeating: false, count: 5)
    @State var isNumbersLoading: Bool = false
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("\(sum ?? 999)")
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
                                await newSetOfNumbers()
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
    func newSetOfNumbers() async {
        isNumbersLoading = true
//        try? await Task.sleep(nanoseconds: 60_000_000_000)
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
