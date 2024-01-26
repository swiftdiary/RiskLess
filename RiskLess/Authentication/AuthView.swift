//
//  AuthView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct AuthView: View {
    @AppStorage("is_signed_in") private var isSignedIn: Bool = false
    @FocusState private var initialEmailText: Bool
    @StateObject private var authVM = AuthViewModel()
    
    
    var body: some View {
        ScrollView {
            Text("Sign Up")
                .font(.largeTitle.bold())
        
            TextField("Email", text: $authVM.emailTextField)
                .focused($initialEmailText)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .padding(.horizontal)
                .font(.headline)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.gray.gradient.opacity(0.4))
                )
            SecureField("Password", text: $authVM.passwordTextField)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.gray.gradient.opacity(0.4))
                )
            Text("By continuing you agree to our [Privacy Policy](https://example.com) & [Terms of Use](https://example.com)")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Button(action: {
                Task {
                    do {
                        try await authVM.signUp()
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
                    authVM.showSignInView = true
                }, label: {
                    Text("Sign In")
                })
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .padding()
        .onAppear(perform: {
            initialEmailText = true
        })
        .sheet(isPresented: $authVM.showSignInView, onDismiss: {
            if authVM.isAuthenticated == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isSignedIn = true
                }
            }
        }, content: {
            SignInView()
                .environmentObject(authVM)
        })
    }
}

#Preview {
    AuthView()
}
