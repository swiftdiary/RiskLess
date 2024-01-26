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
    @State private var showSignInView: Bool = false
    
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle.bold())
            Group {
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
            }
            .padding()
            Button(action: {
                authVM.signUp()
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
                Text("Already have an account? ")
                Button(action: {
                    showSignInView = true
                }, label: {
                    Text("Sign In")
                })
            }
            Spacer()
        }
        .onAppear(perform: {
            initialEmailText = true
        })
        .sheet(isPresented: $showSignInView, onDismiss: {
            if authVM.isAuthenticated == true {
                isSignedIn = true
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
