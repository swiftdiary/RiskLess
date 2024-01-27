//
//  AuthViewModel.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

final class AuthViewModel: ObservableObject {
    
    @Published var emailTextField: String = ""
    @Published var passwordTextField: String = ""
    
    @Published var firstNameTextField: String = ""
    @Published var lastNameTextField: String = ""
    @Published var occupationTextField: String = ""
    @Published var placeOfWorkTextField: String = ""
    @Published var purposeTextField: String = ""
    
    func validateData() throws {
        guard !emailTextField.isEmpty, emailTextField.contains("@"), emailTextField.contains(".") else { throw AuthenticationError.wrongEmail }
        guard !passwordTextField.isEmpty, passwordTextField.count > 6 else { throw AuthenticationError.passwordTooShort }
    }
    
    func signUp() async throws -> String {
        try validateData()
        
        let result = try await NetworkManager.shared.post("/register", jsonBody: [
            "firstName" : firstNameTextField,
            "lastName" : lastNameTextField,
            "email" : emailTextField,
            "password" : passwordTextField,
            "occupation" : occupationTextField,
            "place_of_work" : placeOfWorkTextField,
            "purpose" : purposeTextField
        ], asType: AuthenticationResponse.self)
        return result.token
    }
    
    func signIn() async throws -> String {
        try validateData()
        
        let result = try await NetworkManager.shared.post("/login", jsonBody: [
            "email" : emailTextField,
            "password" : passwordTextField
        ], asType: AuthenticationResponse.self)
        return result.token
    }
}

struct AuthenticationResponse: Codable {
    var token: String
}

enum AuthenticationError: Error {
    case wrongEmail
    case passwordTooShort
}
