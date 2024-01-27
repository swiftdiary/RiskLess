//
//  AuthView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct AuthView: View {
    @AppStorage("is_signed_in") private var isSignedIn: Bool = false
    @AppStorage("sign_in_token") private var signInToken: String = ""
    @FocusState private var initialEmailText: Bool
    @StateObject private var authVM = AuthViewModel()
    @State private var isSignIn: Bool = false // Toggles views
    
    var body: some View {
        if isSignIn {
            SignInView(isSignIn: $isSignIn)
        } else {
            ScrollView {
                Text("Sign Up").font(.largeTitle.bold())
                
                EmailPasswordSection()
                Divider()
                FirstLastNameSection()
                OccupationSection()
                PlaceOfWorkSection()
                PurposeSection()
                Divider()
                SubmitSection()
            }
            .scrollDismissesKeyboard(.immediately)
            .padding()
            .onAppear(perform: {
                initialEmailText = true
            })
            .onDisappear(perform: {
                authVM.emailTextField = ""
                authVM.passwordTextField = ""
                authVM.firstNameTextField = ""
                authVM.lastNameTextField = ""
                authVM.occupationTextField = ""
                authVM.placeOfWorkTextField = ""
                authVM.purposeTextField = ""
            })
        }
    }
    
    @ViewBuilder
    func EmailPasswordSection() -> some View {
        Group {
            TextField("Email", text: $authVM.emailTextField)
                .focused($initialEmailText)
                .customFieldStyles()
            SecureField("Password", text: $authVM.passwordTextField)
                .frame(maxWidth: .infinity)
                .frame(height: 35)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.gray.gradient.opacity(0.4))
                )
        }
    }
    
    @ViewBuilder
    func FirstLastNameSection() -> some View {
        HStack(spacing: 15) {
            TextField("First Name", text: $authVM.firstNameTextField)
                .customFieldStyles()
            TextField("Last Name", text: $authVM.lastNameTextField)
                .customFieldStyles()
        }
    }
    
    @ViewBuilder
    func OccupationSection() -> some View {
        HStack {
            TextField("Occupation (Optional)", text: $authVM.occupationTextField)
                .customFieldStyles()
        }
    }
    
    @ViewBuilder
    func PlaceOfWorkSection() -> some View {
        HStack {
            TextField("Workplace (Optional)", text: $authVM.placeOfWorkTextField)
                .customFieldStyles()
        }
    }
    
    @ViewBuilder
    func PurposeSection() -> some View {
        HStack {
            TextField("Purpose (Optional)", text: $authVM.purposeTextField)
                .customFieldStyles()
        }
    }
    
    @ViewBuilder
    func SubmitSection() -> some View {
        Group {
            Text("By continuing you agree to our [Privacy Policy](https://example.com) & [Terms of Use](https://example.com)")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Button(action: {
                Task {
                    do {
                        signInToken = try await authVM.signUp()
                        isSignedIn = true
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundStyle(.background)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.accent)
                    )
            })
            .padding()
            HStack {
                Text("Already have an account?")
                Button(action: {
                    isSignIn = true
                }, label: {
                    Text("Sign In")
                })
            }
        }
    }
}

#Preview {
    AuthView()
}
