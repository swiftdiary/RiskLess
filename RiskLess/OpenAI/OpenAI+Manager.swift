//
//  OpenAI+Manager.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 30/01/24.
//

import Foundation

final class OpenAIManager {
    static let shared = OpenAIManager()
    private init() { }
    
    func getPredictionResult(envScore: Float, socScore: Float, govScore: Float, company: String, completion: @escaping (String?, Error?) -> ()) {
        let token = "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"
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            print("Invalid URL")
            completion(nil, OpenAIManagerError.urlError)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Set headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let systemPrompt = "You are a financial specialist. And you know very well about Environmental Risk Score, Social Risk Score, Government Risk Score. When user provides you with these data you can explain users what it means in 3 sentences"
        let userPrompt = "Environmental Risk Score: \(envScore), Social Risk Score: \(socScore), Government Risk Score: \(govScore).\nThe company ticker is: \(company)"
        let jsonBody: [ String : Any ] = [
            "model" : "gpt-4-turbo-preview",
            "messages" : [
                [
                    "role" : "system",
                    "content" : systemPrompt
                ],
                [
                    "role" : "user",
                    "content" : userPrompt
                ]
            ]
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonBody)
        } catch {
            print("Error encoding JSON body: \(error)")
            completion(nil, error)
            return
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error making API request: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("Invalid data or response")
                completion(nil, error)
                return
            }
            if response.statusCode == 200 {
                do {
                    let result = try JSONDecoder().decode(ChatGPTResponse.self, from: data)
                    completion(result.choices?.first?.message?.content, nil)
                    print("Completed successfully")
                } catch {
                    print("Error decoding JSON response: \(error)")
                    completion(nil, error)
                }
            } else {
                print("Error: HTTP status code \(response.statusCode)")
                completion(nil, error)
            }
        }
        task.resume()
    }
}

enum OpenAIManagerError: Error {
    case urlError
}


struct ChatGPTResponse: Codable {
    let id, object: String?
    let created: Int?
    let model: String?
    let usage: Usage?
    let choices: [Choice]?
}

// MARK: - Choice
struct Choice: Codable {
    let message: Message?
    let finishReason: String?
    let index: Int?
    
    enum CodingKeys: String, CodingKey {
        case message
        case finishReason = "finish_reason"
        case index
    }
}

// MARK: - Message
struct Message: Codable {
    let role, content: String?
}

// MARK: - Usage
struct Usage: Codable {
    let promptTokens, completionTokens, totalTokens: Int
    
    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}

struct ModerateResponse: Codable {
    let id, model: String?
    let results: [Moderate]?
}

// MARK: - Result
struct Moderate: Codable {
    let flagged: Bool?
    let categoryScores: [String: Double]?
    let categories: [String: Bool]?
    
    enum CodingKeys: String, CodingKey {
        case flagged
        case categoryScores = "category_scores"
        case categories
    }
}
