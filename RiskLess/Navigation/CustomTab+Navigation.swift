//
//  CustomTab+Navigation.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct CustomTab_Navigation: View {
    @State private var selection: TabBarOption = .home
    @EnvironmentObject private var navigationVM: NavigationViewModel
    @Namespace var namespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selection, content: {
                ForEach(TabBarOption.allCases, id: \.self) { option in
                    NavigationStack(path: $navigationVM.path) {
                        option.view
                            .navigationDestination(for: NavigationOption.self) { $0.destination.environmentObject(navigationVM) }
                    }
                }
            })
            ZStack {
                if navigationVM.isTabBarVisible == false {
                    EmptyView()
                } else {
                    HStack {
                        ForEach(TabBarOption.allCases, id: \.self) { option in
                            VStack(spacing: 5) {
                                Image(systemName: option.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(selection == option ? .accent : .primary)
                                if selection == option {
                                    Circle()
                                        .fill(Color.accentColor)
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 8)
                            .background {
                                if selection == option {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .fill(Color.accentColor.gradient.opacity(0.15))
                                        .matchedGeometryEffect(id: "TabBarItem", in: namespace)
                                } else {
                                    EmptyView()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    selection = option
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.bar)
                            .overlay {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .stroke(lineWidth: 0.1)
                                    .foregroundStyle(.primary)
                            }
                    )
                    .shadow(radius: 5.0)
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CustomTab_Navigation().environmentObject(NavigationViewModel())
}
