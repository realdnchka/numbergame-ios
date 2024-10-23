import SwiftUI

struct ContentView: View {
    @State var numbers: Numbers?
    @State var currentSum: Int = 0
    @State var sum: Int?
    @State var isPressedStates: [Bool] = Array(repeating: false, count: 5)
    @State var isNumbersLoading: Bool = true
    
    var body: some View {
        ZStack{
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("\(currentSum)")
                Text("\(sum ?? 999)")
                if isNumbersLoading {
                    HStack {
                        ForEach(numbers?.numbers.indices ?? 0..<5, id: \.self) {
                            n in NumberButtonLoading()
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
            .onAppear() {
                Task {
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
    ContentView()
}
