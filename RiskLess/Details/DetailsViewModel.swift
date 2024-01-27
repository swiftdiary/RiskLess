//
//  DetailsViewModel.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import Foundation

final class DetailsViewModel: ObservableObject {
    @Published var organization: Organization_Detailed? {
        didSet {
            if let organization, !organization.financialIndicators.results.isEmpty {
                financialIndicatorResults = organization.financialIndicators.results
            }
        }
    }
    @Published var financialIndicatorResults: [FinancialIndicator.FinancialResult] = []
    
    func getOrganization(ticker: String) async throws {
//        let response = try await NetworkManager.shared.get("organisations/\(ticker)", asType: nil)
    }
}
