//
//  CategoriesView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject private var categoriesVM = CategoriesViewModel()
    let categoryName: String
    
    var body: some View {
        VStack {
            List(categoriesVM.organizations) { org in
                OrganizationRow(organization: org)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
        }
        .task {
            do {
                try await categoriesVM.getOrganizations(categoryName: categoryName)
            } catch {
                print(error)
            }
        }
        .navigationTitle("\(categoryName.uppercased())S")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func OrganizationRow(organization: OrganizationData) -> some View {
        if let ticker = organization.ticker {
            NavigationLink(value: NavigationOption.details(ticker)) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(organization.shortName ?? "")
                            .font(.headline)
                        Text("\(organization.address ?? ""), \(organization.email ?? ""), \(organization.phone ?? "")")
                            .font(.caption)
                        Text("Director: \(organization.director ?? "")")
                            .font(.headline)
                    }
                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(lineWidth: 0.2)
                        .foregroundStyle(.primary)
                )
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .shadow(radius: 5.0)
            }
        } else {
            Text("There is no Ticker!")
        }
    }
}

#Preview {
    NavigationStack {
        CategoriesView(categoryName: "banks")
    }
}
