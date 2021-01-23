//
//  Category.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

enum Category: String, Codable, CaseIterable {
    
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var urlParam: String {
        switch self {
        case .business:
            return "business"
        case .entertainment:
            return "entertainment"
        case .general:
            return "general"
        case .health:
            return "health"
        case .science:
            return "science"
        case .sports:
            return "sports"
        case .technology:
            return "technology"
        }
    }
    
    var titleForBarButton: String {
        switch self {
        case .business:
            return "businessAbbreviation".localized
        case .entertainment:
            return "entertainmentAbbreviation".localized
        case .general:
            return "generalAbbreviation".localized
        case .health:
            return "healthAbbreviation".localized
        case .science:
            return "scienceAbbreviation".localized
        case .sports:
            return "sportsAbbreviation".localized
        case .technology:
            return "technologyAbbreviation".localized
        }
    }
    
    var title: String {
        switch self {
        case .business:
            return "businessTitle".localized
        case .entertainment:
            return "entertainmentTitle".localized
        case .general:
            return "generalTitle".localized
        case .health:
            return "healthTitle".localized
        case .science:
            return "scienceTitle".localized
        case .sports:
            return "sportsTitle".localized
        case .technology:
            return "technologyTitle".localized
        }
    }
}
