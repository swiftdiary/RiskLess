//
//  Organization+Detailed.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 28/01/24.
//

import Foundation

// /organisations/<ticker>

struct Organization_Detailed: Codable {
    var financialIndicators: [FinancialIndicator]
    var orgInfo: OrgInfo
}

struct FinancialIndicator: Codable {
    
}

struct OrgInfo: Codable {
    
}
