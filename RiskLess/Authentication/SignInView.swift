//
//  SignInView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct SignInView: View {
    @Binding var isSignIn: Bool
    
    @FocusState private var initialEmailText: Bool
    @AppStorage("sign_in_token") private var signInToken: String = ""
    @AppStorage("is_signed_in") private var isSignedIn: Bool = false
    @StateObject private var authVM: AuthViewModel = AuthViewModel()
    
    var body: some View {
        ScrollView {
            Text("Sign In")
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
            }
            .padding()
            Button(action: {
                Task {
                    do {
                        signInToken = try await authVM.signIn()
                        isSignedIn = true
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                Text("Sign In")
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
                Text("Don't have an account?")
                Button(action: {
                    isSignIn = false
                }, label: {
                    Text("Sign Up")
                })
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .onAppear(perform: {
            initialEmailText = true
        })
    }
}

#Preview {
    SignInView(isSignIn: .constant(true)).environmentObject(AuthViewModel())
}
