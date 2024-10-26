//
//  Endpoints.swift
//  numbergame
//
//  Created by Danil Chernov on 25/10/24.
//
import Foundation

/// Endpoint for fetching numbers from server /getNumbers
/// - Parameter count: How many numbers do you want to generate
///
func getNumbers(count: Int = 5) async -> Numbers {
    do {
        let result: Numbers = try await RequestBuilder()
            .withEndpoint(endpoint: "getNumbers")
            .withMethod(method: .GET)
            .withQueryParam(name: "count", value: String(count))
            .sendRequest()
            .decodeResponse()

        return result
    } catch {
        return Numbers(numbers: [], sum: 0)
    }
}

func isNameTaken(username: String) async throws {
    do {
        let response: HTTPURLResponse = try await RequestBuilder()
            .withEndpoint(endpoint: "isNameTaken")
            .withMethod(method: .GET)
            .withQueryParam(name: "username", value: username)
            .sendRequest()
            .getResponse()
        
        if response.statusCode == 404 {
            try await registerUser(username: username)
        }
    } catch {
        throw error
    }
}

func registerUser(username: String) async throws {
    let name = username
    
    do {
        let(data, response): (UserToken, HTTPURLResponse) = try await RequestBuilder()
            .withEndpoint(endpoint: "userCreate")
            .withMethod(method: .POST)
            .withBody(UserRegister(username: name))
            .sendRequest()
            .decodeAndResponse()

        if response.statusCode == 200 {
            UserDefaults.standard.set(name, forKey: "username")
            UserDefaults.standard.set(data.token, forKey: "token")
        }
        
    } catch {
        throw error
    }
}

func loginUser(username: String, token: String) async throws -> Bool {
    do {
        let response: HTTPURLResponse = try await RequestBuilder()
            .withEndpoint(endpoint: "userLogin")
            .withMethod(method: .POST)
            .withBody(UserLogin(username: username, token: token))
            .sendRequest()
            .getResponse()

        if response.statusCode == 200 {
            //fetch user scores
            return true
        } else {
            return false
        }
        
    } catch {
        throw error
    }
}

func userGetData() async throws -> User {
    do {
        let username = UserDefaults.standard.string(forKey: "username")!
        let response: User = try await RequestBuilder()
            .withEndpoint(endpoint: "userGetData")
            .withQueryParam(name: "username", value: username)
            .withMethod(method: .GET)
            .sendRequest()
            .decodeResponse()
        
        return response
    } catch {
        throw error
    }
}

func sendScore(score: Int) async throws {
    do {
        try await RequestBuilder()
            .withEndpoint(endpoint: "sendScore")
            .withBody(User(username: UserDefaults.standard.string(forKey: "username")!, highscore: score, total_scores: 0, token: UserDefaults.standard.string(forKey: "token")!))
            .withMethod(method: .POST)
            .sendRequest()
    } catch {
        throw error
    }
}

struct User: Codable {
    let username: String
    let highscore: Int
    let total_scores: Int
    let token: String
}

struct UserRegister: Codable {
    let username: String
}

struct UserToken: Codable {
    let token: String
}

struct UserLogin: Codable {
    let username: String
    let token: String
}

struct Numbers: Codable {
    let numbers: [Int]
    let sum: Int
}
