//
//  DetailsView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import SwiftUI

struct DetailsView: View {
    @StateObject private var detailsVM = DetailsViewModel()
    
    let ticker: String
    
    var body: some View {
        VStack {
            ScrollView {
                Header()
                BodySection()
            }
        }
        
        .navigationTitle("Details")
    }
    
    @ViewBuilder
    func Header() -> some View {
        HStack {
            VStack {
                
            }
            .frame(maxWidth: .infinity)
            VStack(alignment: .leading, spacing: 20) {
                Text("Some bank")
                    .font(.title2.bold())
                Text("Details information +998909090909. 3290 2r42n 2ij2 m24j2 mk2m")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.accentColor.opacity(0.3))
            )
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func BodySection() -> some View {
        VStack {
            HStack {
                Text("")
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        DetailsView(ticker: "1")
    }
}
