//
//  FavoritesView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var favoritesVM = FavoritesViewModel()
    
    var body: some View {
        VStack {
            List {
                
            }
        }
        .navigationTitle("Favorites")
    }
}

#Preview {
    NavigationStack {
        FavoritesView()
    }
}
