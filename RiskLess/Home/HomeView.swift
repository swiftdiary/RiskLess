//
//  HomeView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            NavigationLink(value: NavigationOption.details) {
                Text("Go to details")
            }
        }
    }
}

#Preview {
    HomeView()
}
