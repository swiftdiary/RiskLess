//
//  DetailsView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import SwiftUI
import Charts

struct DetailsView: View {
    @StateObject private var detailsVM = DetailsViewModel()
    @State private var currentType: String = "total_assets" // "total_equity"
    @State private var currentChartMarkType: String = "bar" // "line"
    let ticker: String
    
    var body: some View {
        VStack {
            ScrollView {
                Header()
                BodySection()
                TableSection()
            }
        }
        .task {
            do {
                try await detailsVM.getOrganization(ticker: ticker)
            } catch {
                print(error)
            }
        }
        .navigationTitle("\(ticker.capitalized)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func Header() -> some View {
        if let organization = detailsVM.organization {
            HStack {
                VStack {
                    Image(.banks)
                        .resizable()
                        .scaledToFit()
                }
                .frame(maxWidth: .infinity)
                VStack(alignment: .leading, spacing: 20) {
                    Text(organization.orgInfo.shortNameText)
                        .font(.title2.bold())
                    Text(organization.orgInfo.fullNameText)
                        .font(.caption)
                    Text("TIN: \(organization.orgInfo.inn)")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.accentColor.opacity(0.3))
                )
                .padding(.horizontal)
            }
        } else {
            ProgressView()
        }
    }
    
    @ViewBuilder
    func BodySection() -> some View {
        if let organization = detailsVM.organization {
            VStack(alignment: .leading) {
                HStack {
                    Text("Financial Indicators")
                        .font(.headline)
                }
                HStack {
                    Picker("Type", selection: $currentType) {
                        Text("Total Assets")
                            .tag("total_assets")
                        Text("Total Equity")
                            .tag("total_equity")
                    }
                    .pickerStyle(.segmented)
                }
                Chart {
                    ForEach(detailsVM.financialIndicatorResults) { result in
                        if currentChartMarkType == "bar" {
                            BarMark(
                                x: .value("Year", result.reportingYear),
                                y: .value("So'm", currentType == "total_assets" ? result.totalAssets : result.totalEquity)
                            )
                        } else {
                            LineMark(
                                x: .value("Year", result.reportingYear),
                                y: .value("So'm", currentType == "total_assets" ? result.totalAssets : result.totalEquity)
                            )
                        }
                    }
                }
                .frame(height: 200)
                HStack {
                    Picker("Chart", selection: $currentChartMarkType) {
                        Image(systemName: "chart.bar.xaxis")
                            .tag("bar")
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .tag("line")
                    }
                    .pickerStyle(.segmented)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        } else {
            ProgressView()
        }
    }
    
    @ViewBuilder
    func TableSection() -> some View {
        if let organization = detailsVM.organization {
            Text("Here will be a table section...")
        } else {
            ProfileView()
        }
    }
}

#Preview {
    NavigationStack {
        DetailsView(ticker: "1")
    }
}
