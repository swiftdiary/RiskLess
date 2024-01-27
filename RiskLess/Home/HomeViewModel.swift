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
        print("HEADERS TOKEN: \(UserDefaults.standard.string(forKey: "sign_in_token") ?? "No token")")
    }
}

