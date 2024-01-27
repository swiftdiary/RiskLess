//
//  CategoriesViewModel.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import SwiftUI

final class CategoriesViewModel: ObservableObject {
    @Published var organizations = [OrganizationData]()
    
    func getOrganizations(categoryName: String) async throws {
        let result = try await NetworkManager.shared.get("/organisations", queries: ["org_type" : categoryName], asType: Organization.self)
        await MainActor.run {
            self.organizations = result.data
        }
    }
}
