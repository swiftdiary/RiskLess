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
    
    @Published var gptResponse: String?
    @Published var loading: Bool = false
    
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
    
    func aiSuggestionRequest(prediction: Prediction, company: String) {
        DispatchQueue.main.async {
            self.loading = true
        }
        OpenAIManager.shared.getPredictionResult(envScore: prediction.envScore, socScore: prediction.socScore, govScore: prediction.govScore, company: company) { result, error in
            if let error {
                print(error)
            } else if let result {
                DispatchQueue.main.async {
                    self.gptResponse = result
                    self.loading = false
                }
            } else {
                print("Nothing")
            }
        }
    }
}
