//
//  Prediction.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 28/01/24.
//

import Foundation

struct Prediction: Identifiable, Codable {
    let id = UUID()
    var envScore: Float
    var socScore: Float
    var govScore: Float
    
    enum CodingKeys: String, CodingKey {
        case envScore = "env_score"
        case socScore = "soc_score"
        case govScore = "gov_score"
    }
}
