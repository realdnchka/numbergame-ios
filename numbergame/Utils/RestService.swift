//
//  RestService.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import Foundation

class RequestBuilder {
    private var request: URLRequest
    private var data: Data = Data()
    private var response: HTTPURLResponse = HTTPURLResponse()
    
    init() {
        self.request = URLRequest(url: URL(string: Config.apiURL)!)
    }
    
    func withEndpoint(endpoint: String) -> RequestBuilder {
        request.url = request.url!.appendingPathComponent(endpoint)
        return self
    }
    
    func withMethod(method: ApiMethod) -> RequestBuilder {
        request.httpMethod = method.rawValue
        return self
    }
    
    func withQueryParam(name: String, value: String) -> RequestBuilder {
        var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)
        
        var queryItems = urlComponents?.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value))
        urlComponents?.queryItems = queryItems
        request.url = urlComponents?.url
        return self
    }
    
    func withBody<T: Encodable>(_ body: T) -> RequestBuilder {
        request.httpBody = try? JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return self
    }
    
    func logRequest(_ request: URLRequest) {
        print("🚀 [Request] \(request.httpMethod ?? "No HTTP Method") \(request.url?.absoluteString ?? "No URL")")
        
        if let headers = request.allHTTPHeaderFields {
            print("Headers:")
            for (key, value) in headers {
                print("  \(key): \(value)")
            }
        }
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("Body:")
            print(bodyString)
        } else {
            print("No Body")
        }
    }
    
    func sendRequest() async throws -> RequestBuilder {
        request.addValue(Config.apiKey, forHTTPHeaderField: "Authorization")
        logRequest(request)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        self.data = data
        self.response = httpResponse
        
        return self
    }
    
    func decodeResponse<T: Codable>() async throws -> T {
        return try JSONDecoder().decode(T.self, from: self.data)
    }
    
    func getResponse() async throws -> HTTPURLResponse {
        return self.response
    }
    
    func decodeAndResponse<T: Codable>() async throws -> (T, HTTPURLResponse) {
        return try await (decodeResponse(), getResponse())
    }
    
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidStatusCode
}

enum ApiMethod: String {
    case POST = "POST"
    case GET = "GET"
}
