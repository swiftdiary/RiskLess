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
                    TopOrganizations()
                    
                    AllCategories()
                }
            }
        }
        .task {
            do {
                try await homeVM.getOrganisations()
            } catch {
                // Handle error
            }
        }
        .background(Color.lightGreen)
        .navigationTitle("Home")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.lightGreen, for: .navigationBar)
    }
    
    @ViewBuilder
    func TopOrganizations() -> some View {
        Group {
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
                    ForEach(homeVM.organisations) { org in
                        VStack {
                            Text("Name: \(org.shortName)")
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
        }
    }
    
    @ViewBuilder
    func AllCategories() -> some View {
        VStack {
            HStack {
                Text("All Categories")
                    .font(.title2.bold())
                Spacer()
            }
            .padding()
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10, content: {
                VStack {
                    Image(.jsc)
                        .resizable()
                        .scaledToFit()
                    Text("JSC")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                NavigationLink(value: NavigationOption.categories("banks")) {
                    VStack {
                        Image(.banks)
                            .resizable()
                            .scaledToFit()
                        Text("Banks")
                            .font(.headline)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.primary)
                
                VStack {
                    Image(.llc)
                        .resizable()
                        .scaledToFit()
                    Text("LLC")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack {
                    Image(.insurances)
                        .resizable()
                        .scaledToFit()
                    Text("Insurances")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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

#Preview {
    NavigationStack {
        HomeView()
    }
}
