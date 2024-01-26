//
//  SignInView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct SignInView: View {
    @FocusState private var initialEmailText: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        VStack {
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
                        try await authVM.signIn()
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
            Spacer()
        }
        .onChange(of: authVM.isAuthenticated, perform: { newValue in
            if newValue == true {
                dismiss()
            }
        })
        .onAppear(perform: {
            initialEmailText = true
        })
    }
}

#Preview {
    SignInView().environmentObject(AuthViewModel())
}
