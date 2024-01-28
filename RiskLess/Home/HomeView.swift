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
                print(error)
            }
        }
        .navigationTitle("Home")
    }
    
    @ViewBuilder
    func TopOrganizations() -> some View {
        Group {
            HStack {
                Text("Top 5 companies")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            ScrollView(.horizontal) {
                HStack {
                    if homeVM.organisations.isEmpty {
                        ProgressView()
                            .frame(height: 150)
                    } else {
                        ForEach(homeVM.organisations) { org in
                            HStack(spacing: 10) {
                                Image(.banks)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(org.shortName ?? "")")
                                        .font(.headline)
                                    Text("\(org.email ?? "")")
                                        .font(.caption)
                                    Text("\(org.phone ?? "")")
                                        .font(.caption2)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .frame(width: 250, height: 150)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.accentColor.opacity(0.3).gradient)
                            )
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
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
                
                NavigationLink(value: NavigationOption.categories("bank")) {
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
                .fill(.themeBackground.opacity(0.7))
        )
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
