//
//  View+Extensions.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 28/01/24.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func customFieldStyles() -> some View {
        frame(maxWidth: .infinity)
        .frame(height: 35)
        .padding(.horizontal)
        .font(.headline)
        .background(
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.gray.gradient.opacity(0.4))
        )
    }
}
