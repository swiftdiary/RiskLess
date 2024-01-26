//
//  AuthViewModel.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

final class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var emailTextField: String = ""
    @Published var passwordTextField: String = ""
    
    func signUp() {
        
    }
    
    func signIn() async throws {
        await MainActor.run {
            self.isAuthenticated = true
        }
    }
}
