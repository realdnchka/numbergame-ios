//
//  Endpoints.swift
//  numbergame
//
//  Created by Danil Chernov on 25/10/24.
//

/// Endpoint for fetching numbers from server /getNumbers
/// - Parameter count: How many numbers do you want to generate
///
func getNumbers(count: Int = 5) async -> Numbers {
    do {
        let result: Numbers = try await RequestBuilder()
            .withEndpoint(endpoint: "/getNumbers")
            .withMethod(method: .GET)
            .withQueryParam(name: "count", value: String(count))
            .sendRequest()
        
        return result
    } catch {
        return Numbers(numbers: [], sum: 0)
    }
}

struct Numbers: Codable {
    let numbers: [Int]
    let sum: Int
}
