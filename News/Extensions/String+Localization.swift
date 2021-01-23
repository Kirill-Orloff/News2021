//
//  String+Localization.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Foundation

extension String {
    
    // MARK: - Internal
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
