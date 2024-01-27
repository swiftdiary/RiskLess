//
//  HomeViewModel.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var organisations = [OrganizationData]()
    
    func getOrganisations() async throws {
        let organisations = try await NetworkManager.shared.get("/organisations", queries: ["org_type" : "bank"], asType: Organization.self)
        await MainActor.run {
            withAnimation(.bouncy) {
                self.organisations = organisations.data
            }
        }
    }
}

