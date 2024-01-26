//
//  ProfileView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("is_signed_in") private var isSignedIn: Bool = false
    @AppStorage("is_quiz_passed") private var isQuizPassed: Bool = false
    
    @StateObject private var profileVM = ProfileViewModel()
    
    var body: some View {
        VStack {
            List {
                Section("Edit") {
                    HStack {
                        Text("Name:")
                        Text("Akbar")
                            .font(.headline)
                    }
                }
                Section {
                    Button(action: {
                        isSignedIn = false
                        isQuizPassed = false
                    }, label: {
                        Text("Sign Out")
                    })
                    .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
