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
//                TableSection()
                QuickAnalysis()
            }
        }
        .sheet(item: $detailsVM.prediction, onDismiss: {
            print("Dismissed")
        }, content: { prediction in
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("TOTAL SCORE: \(String(format: "%.2f", (prediction.envScore + prediction.socScore + prediction.govScore)))")
                        .font(.title2.bold())
                    Text("Total ESG Risk Score - a comprehensive assessment that quantifies the Environmental, Social, and Governance (ESG) risks associated with an investment or a company, considering factors such as environmental impact, social responsibility, and governance practices.")
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("ENV SCORE: \(String(format: "%.2f", prediction.envScore))")
                        .bold()
                    Text("Environment Risk Score - a metric used to evaluate the potential environmental risks and impacts associated with an investment, company, or project, assessing factors such as pollution, resource usage, and climate change vulnerabilities.")
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("SOC SCORE: \(String(format: "%.2f", prediction.socScore))")
                        .bold()
                    Text("Social Risk Score - a metric used to evaluate the potential social impact and risks associated with an investment or company, focusing on factors such as labor practices, community relations, diversity and inclusion, and human rights considerations.")
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("GOV SCORE: \(String(format: "%.2f", prediction.govScore))")
                        .bold()
                    Text("Government Risk Score - a measurement used to assess the level of political and regulatory risks inherent in an investment or company, considering factors such as government stability, legal framework, political transparency, and regulatory environment.")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        })
        .task {
            do {
                try await detailsVM.getOrganization(ticker: ticker)
            } catch {
                print(error)
            }
        }
        .navigationTitle("\(ticker.uppercased())")
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
                    Text(organization.orgInfo?.shortNameText ?? "")
                        .font(.title3.bold())
                    Text(organization.orgInfo?.fullNameText ?? "")
                        .font(.caption)
                    Text("TIN: \(organization.orgInfo?.inn ?? 0)")
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
        if detailsVM.organization != nil {
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
                        if let reportingYear = result.reportingYear, let totalAssets = result.totalAssets, let totalEquity = result.totalEquity {
                            if currentChartMarkType == "bar" {
                                BarMark(
                                    x: .value("Year", reportingYear.description),
                                    y: .value("So'm", currentType == "total_assets" ? totalAssets : totalEquity)
                                )
                            } else {
                                LineMark(
                                    x: .value("Year", reportingYear.description),
                                    y: .value("So'm", currentType == "total_assets" ? totalAssets : totalEquity)
                                )
                            }
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
        if detailsVM.organization != nil {
            Text("Here will be a table section...")
        } else {
            ProfileView()
        }
    }
    
    @ViewBuilder
    func QuickAnalysis() -> some View {
        HStack {
            Button("Quick Analysis") {
                Task {
                    do {
                        try await detailsVM.quickAnalysis(ticker: ticker)
                    } catch {
                        print(error)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .font(.headline)
            .foregroundStyle(.background)
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.accentColor.gradient)
            )
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        DetailsView(ticker: "1")
    }
}

