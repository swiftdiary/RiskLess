//
//  ContentView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationVM = NavigationViewModel()
    
    var body: some View {
        CustomTab_Navigation()
            .environmentObject(navigationVM)
    }
}

#Preview {
    ContentView()
}
