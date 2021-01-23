//
//  Country.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import UIKit

enum Country: String, Codable, CaseIterable {
    
    case canada
    case france
    case germany
    case russia
    case unitedKingdom
    case unitedStates
    
    var urlParam: String {
        switch self {
        case .canada:
            return "ca"
        case .france:
            return "fr"
        case .germany:
            return "de"
        case .russia:
            return "ru"
        case .unitedKingdom:
            return "gb"
        case .unitedStates:
            return "us"
        }
    }
    
    var titleForBarButton: String {
        switch self {
        case .canada:
            return "canadaAbbreviation".localized
        case .france:
            return "franceAbbreviation".localized
        case .germany:
            return "germanyAbbreviation".localized
        case .russia:
            return "russiaAbbreviation".localized
        case .unitedKingdom:
            return "unitedKingdomAbbreviation".localized
        case .unitedStates:
            return "unitedStatesAbbreviation".localized
        }
    }
    
    var title: String {
        switch self {
        case .canada:
            return "canadaTitle".localized
        case .france:
            return "franceTitle".localized
        case .germany:
            return "germanyTitle".localized
        case .russia:
            return "russiaTitle".localized
        case .unitedKingdom:
            return "unitedKingdomTitle".localized
        case .unitedStates:
            return "unitedStatesTitle".localized
        }
    }
    
    var image: UIImage? {
        switch self {
        case .canada:
            return UIImage(named: "icCanadaFlag")
        case .france:
            return UIImage(named: "icFranceFlag")
        case .germany:
            return UIImage(named: "icGermanyFlag")
        case .russia:
            return UIImage(named: "icRussiaFlag")
        case .unitedKingdom:
            return UIImage(named: "icUnitedKingdomFlag")
        case .unitedStates:
            return UIImage(named: "icUnitedStatesFlag")
        }
    }
}
