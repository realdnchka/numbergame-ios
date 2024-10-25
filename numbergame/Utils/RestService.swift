//
//  RestService.swift
//  numbergame
//
//  Created by Danil Chernov on 23/10/24.
//

import Foundation

class RequestBuilder {
    private var request: URLRequest
    
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
    
    func sendRequest<T: Codable>() async throws -> T{
        request.addValue(Config.apiKey, forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}

enum ApiMethod: String {
    case POST = "POST"
    case GET = "GET"
}
