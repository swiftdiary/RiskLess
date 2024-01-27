//
//  NetworkManager.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    static let baseURL = "https://riskless.onrender.com"
    private init() { }
    
    func createURL(path: String, queries: [String: String]?) -> URL {
        var components = URLComponents(string: Self.baseURL)!
        components.path = path
        components.queryItems = queries?.map({ URLQueryItem(name: $0.key, value: $0.value) })
        return components.url!
    }
    
    func createRequest(url: URL, method: String, jsonBody: [String: Any]? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let jsonBody = jsonBody {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
            } catch {
                print("Error serializing JSON: \(error)")
            }
        }
        
        return request
    }
    
    func configureRequest<T: Decodable>(request: inout URLRequest, asType: T.Type?) {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let responseType = asType {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
    
    func handleResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, asType: T.Type?) throws -> T {
        if let error = error {
            throw error
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }

        guard let responseData = data else {
            throw NetworkError.invalidData
        }

        do {
            if let responseType = asType {
                let decodedResponse = try JSONDecoder().decode(responseType, from: responseData)
                return decodedResponse
            } else {
                throw NetworkError.invalidResponseType
            }
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func performRequest<T: Decodable>(path: String, queries: [String: String]?, method: String, jsonBody: [String: Any]? = nil, asType: T.Type?) async throws -> T {
        let url = createURL(path: path, queries: queries)
        var request = createRequest(url: url, method: method, jsonBody: jsonBody)
        configureRequest(request: &request, asType: asType)

        let (data, response) = try await URLSession.shared.data(for: request)
        return try handleResponse(data: data, response: response, error: nil, asType: asType)
    }
    
    func get<T:Decodable>(_ path: String, queries: [String: String]? = nil, jsonBody: [String: Any]? = nil, asType: T.Type) async throws -> T {
        try await performRequest(path: path, queries: queries, method: "GET", jsonBody: jsonBody, asType: T.self)
    }
    
    func post<T:Decodable>(_ path: String, queries: [String: String]? = nil, jsonBody: [String: Any]? = nil, asType: T.Type) async throws -> T {
        try await performRequest(path: path, queries: queries, method: "POST", jsonBody: jsonBody, asType: T.self)
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError(Error)
    case statusCode(Int)
    case invalidResponseType
}
