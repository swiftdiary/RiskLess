//
//  Organization+Top.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 28/01/24.
//

import Foundation

struct Organization_Top: Codable {
    let data: [OrganizationData]

    struct OrganizationTopDetails: Codable {
        let netProfit: Double
        let orgId: Int
        let orgShortInfo: OrganizationData

        private enum CodingKeys: String, CodingKey {
            case netProfit = "net_profit"
            case orgId = "org_id"
            case orgShortInfo = "org_short_info"
        }
    }
}

