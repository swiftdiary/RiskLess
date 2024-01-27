//
//  ProfileView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("is_signed_in") private var isSignedIn: Bool = false
    @AppStorage("sign_in_token") private var signInToken: String = ""
    @AppStorage("is_premium") private var isPremium: Bool = false
    @State private var showPaywall: Bool = false
    
    @StateObject private var profileVM = ProfileViewModel()
    
    var body: some View {
        VStack {
            List {
                Section("Info") {
                    Button("👑 Premium") {
                        if !isPremium {
                            showPaywall.toggle()
                        }
                    }
                    Text("Terms of Use")
                    Text("Privacy Policy")
                }
                Section {
                    Button(action: {
                        isSignedIn = false
                        signInToken = ""
                    }, label: {
                        Text("Sign Out")
                    })
                    .foregroundStyle(.red)
                }
            }
        }
        .sheet(isPresented: $showPaywall, content: {
            PaywallView()
        })
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
