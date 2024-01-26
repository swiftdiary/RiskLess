//
//  HomeView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 26/01/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack {
                    HStack {
                        Text("Top 5 companies")
                            .font(.headline)
                        Spacer()
                        Text("By quarter income")
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<5) { _ in
                                VStack {
                                    
                                }
                                .frame(width: 250, height: 150)
                                .background(
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .fill(Color.accentColor.gradient)
                                )
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        }
                    }
                    VStack {
                        HStack {
                            Text("All Categories")
                                .font(.title2.bold())
                            Spacer()
                        }
                        .padding()
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10, content: {
                            ForEach(0..<4) { _ in
                                VStack {
                                    HStack{}.frame(height: 200)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .fill(Color.accentColor.gradient.opacity(0.4))
                                }
                            }
                        })
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.background)
                    )
                }
            }
        }
        .background(Color.lightGreen)
        .navigationTitle("Home")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.lightGreen, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
