//
//  DetailsViewModel.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import Foundation

final class DetailsViewModel: ObservableObject {
    
    
    func getOrganization(ticker: String) async throws {
        let response = try await NetworkManager.shared.get("organisations/\(ticker)", asType: nil)
    }
}
