//
//  NavigationViewModel.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

final class NavigationViewModel: ObservableObject {
    @Published var path: [NavigationOption] = [] {
        didSet {
            if !path.isEmpty {
                withAnimation(.bouncy) {
                    self.isTabBarVisible = false
                }
            } else {
                withAnimation(.bouncy) {
                    self.isTabBarVisible = true
                }
            }
        }
    }
    
    @Published var isTabBarVisible: Bool = true
}

enum NavigationOption: Hashable {
    case details(String)
    case categories(String)
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .details(let ticker):
            DetailsView(ticker: ticker)
        case .categories(let name):
            CategoriesView(categoryName: name)
        }
    }
}

enum TabBarOption: Hashable, CaseIterable {
    case home
    case profile
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .home: HomeView().tag(self)
        case .profile: ProfileView().tag(self)
        }
    }
    
    var iconName: String {
        switch self {
        case .home: "house.circle"
        case .profile: "person.crop.circle"
        }
    }
}
