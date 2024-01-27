//
//  Organization+Detailed.swift
//  RiskLess
//
//  Created by Akbar Khusanbaev on 28/01/24.
//

import Foundation

// /organisations/<ticker>

struct Organization_Detailed: Codable {
    var financialIndicators: [FinancialIndicator]
    var orgInfo: OrgInfo
    
    enum CodingKeys: String, CodingKey {
        case financialIndicators = "financial_indicators"
        case orgInfo = "org_info"
    }
}

struct FinancialIndicator: Codable {
    
}

struct OrgInfo: Codable {
    let id: Int
    let detailInfo: DetailInfo
    let infoRfb: InfoRfb
    let inn: Int
    let fullNameText: String
    let shortNameText: String
    let exchangeTicketName: String
    let location: String
    let address: String
    let email: String
    let webSite: String
    let status: Bool
    let nameSuffixId: Int
    let responsiblePersonId: Int
    let accountNumber: String
    let govRegNumber: String
    let kfs: Int
    let mfo: String
    let okonx: Int
    let okpo: Int
    let servingBank: String
    let soato: Int
    let onMaps: String
    let region: String

    private enum CodingKeys: String, CodingKey {
        case id
        case detailInfo = "detailinfo"
        case infoRfb = "info_rfb"
        case inn
        case fullNameText = "full_name_text"
        case shortNameText = "short_name_text"
        case exchangeTicketName = "exchange_ticket_name"
        case location
        case address
        case email
        case webSite = "web_site"
        case status
        case nameSuffixId = "name_suffix_id"
        case responsiblePersonId = "responsible_person_id"
        case accountNumber = "account_number"
        case govRegNumber = "gov_reg_number"
        case kfs
        case mfo
        case okonx
        case okpo
        case servingBank = "serving_bank"
        case soato
        case onMaps = "on_maps"
        case region
    }
}

struct DetailInfo: Codable {
    let id: Int
    let shortInfoRu: String
    let shortInfoUz: String
    let shortInfoEn: String
    let directorName: String
    let review: String
    let phoneNumber: String
    let logoFile: String
    let updatedAt: String
    let createdAt: String
    let organization: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case shortInfoRu = "short_info_ru"
        case shortInfoUz = "short_info_uz"
        case shortInfoEn = "short_info_en"
        case directorName = "director_name"
        case review
        case phoneNumber = "phone_number"
        case logoFile = "logo_file"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case organization
    }
}

struct InfoRfb: Codable {
    let statusRfb: Bool
    let isinCodes: [IsinCode]
    let ustavCapitalization: Double
    let defaultIsuCd: String

    private enum CodingKeys: String, CodingKey {
        case statusRfb = "status_rfb"
        case isinCodes = "isin_codes"
        case ustavCapitalization = "ustav_capitalization"
        case defaultIsuCd = "default_isu_cd"
    }
}

struct IsinCode: Codable {
    let isuCd: String
    let market: String
    let ticker: String
    let issuerShortName: String
    let listingDate: String
    let tradingCurrency: String
    let price: Double
    let stockType: String

    private enum CodingKeys: String, CodingKey {
        case isuCd
        case market
        case ticker
        case issuerShortName
        case listingDate = "listing_date"
        case tradingCurrency = "trading_currency"
        case price
        case stockType = "stock_type"
    }
}
