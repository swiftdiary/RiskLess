//
//  Organization.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 27/01/24.
//

import Foundation

// {"address":"Андижанская область, г. Андижан, пр.Бобура, 85","director":"Jo‘rayev Baxtiyorjon Tuymuratovich","email":"muloqot@hamkorbank.uz","org_id":8,"phone":"742981000","short_name":"\"Hamkorbank\" ATB"}

struct Organization: Codable {
    var data: [OrganizationData]
}

struct OrganizationData: Identifiable, Codable {
    var id: Int
    var address: String
    var director: String
    var email: String
    var phone: String
    var shortName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "org_id"
        case address
        case director
        case email
        case phone
        case shortName = "short_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.address = try values.decode(String.self, forKey: .address)
        self.director = try values.decode(String.self, forKey: .director)
        self.email = try values.decode(String.self, forKey: .email)
        self.phone = try values.decode(String.self, forKey: .phone)
        self.shortName = try values.decode(String.self, forKey: .shortName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.director, forKey: .director)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.phone, forKey: .phone)
        try container.encode(self.shortName, forKey: .shortName)
    }
    
}
