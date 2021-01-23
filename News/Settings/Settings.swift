//
//  Settings.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

struct Settings {
    
    @Storage(key: .selectedCountry, defaultValue: .unitedStates)
    static var selectedCountry: Country
    
    @Storage(key: .selectedCategory, defaultValue: .general)
    static var selectedCategory: Category
    
    @Storage(key: .firstLaunchHintWasShowed, defaultValue: false)
    static var firstLaunchHintWasShowed: Bool
}
