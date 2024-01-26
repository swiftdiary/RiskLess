//
//  CategoriesView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject private var categroriesVM = CategoriesViewModel()
    
    var body: some View {
        VStack {
            // Here bill be as list of all items
            List {
                Text("HEHEHE")
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Category name")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CategoriesView()
    }
}
