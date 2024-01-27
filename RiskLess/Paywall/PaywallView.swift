//
//  PaywallView.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("is_premium") private var isPremium: Bool = false
    @StateObject private var paywallVM = PaywallViewModel()
    @State private var isEligibleForOffer: Bool = false
    @State private var paid: Bool = false
    
    var body: some View {
        VStack {
            if let product = paywallVM.products.first {
                ScrollView {
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        Spacer()
                    }
                    .padding()
                    HStack {
                        Text("👑 " + product.displayName + " " + product.description)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    HStack {
                        Text("Get premium access to all features for just \(product.displayPrice)/month")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    if isEligibleForOffer {
                        Text("You can start your 1 month free trial. And pay \(product.displayPrice) after subscription")
                            .font(.headline)
                    }
                    
                }
                Button {
                    Task {
                        do {
                            try await paywallVM.purchase(product)
                            paid = try await paywallVM.isPurchased(product)
                        } catch {
                            // Handle errors later
                        }
                    }
                } label: {
                    if isEligibleForOffer {
                        Text("Start your monthly Trial")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.accentColor.gradient)
                            )

                    } else {
                        Text("Continue for \(product.displayPrice)")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                            .background(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .fill(Color.accentColor.gradient)
                            )
                    }
                }
                .foregroundStyle(.background)
                .padding()
            }
        }
        .onChange(of: paid, perform: { newValue in
            if newValue {
                isPremium = true
                dismiss()
            }
        })
        .task(priority: .high, {
            self.isEligibleForOffer = await paywallVM.isEligibleForFreeTrial()
        })
        .presentationDetents([.medium])
    }
}

#Preview {
    NavigationStack {
        PaywallView()
    }
}
