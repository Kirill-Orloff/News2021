//
//  SettingsType.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

enum SettingsType {
    
    case countries
    case categories
    
    var settingsTitle: String {
        switch self {
        case .countries:
            return "countriesTitle".localized
        case .categories:
            return "categoriesTitle".localized
        }
    }
}
