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
            if let organization, let financialIndicators = organization.financialIndicators, let results = financialIndicators.results, !results.isEmpty {
                financialIndicatorResults = results
            }
        }
    }
    @Published var financialIndicatorResults: [FinancialIndicator.FinancialResult] = []
    
    @Published var prediction: Prediction?
    
    func getOrganization(ticker: String) async throws {
        let response = try await NetworkManager.shared.get("/organisations/\(ticker)", asType: Organization_Detailed.self)
        await MainActor.run {
            self.organization = response
        }
    }
    
    func quickAnalysis(ticker: String) async throws {
        let response = try await NetworkManager.shared.get("/predict", queries: [
            "ticker" : ticker,
            "org_type" : "bank"
        ], asType: Prediction.self)
        await MainActor.run {
            self.prediction = response
        }
    }
}
