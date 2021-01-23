//
//  PresentableError.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

class PresentableError: Error {
    
    // MARK: - Vars
    let title: String
    let message: String
    
    // MARK: - Inits
    convenience init() {
        self.init(title: "alertErrorTitle".localized, message: "alertDefaultError".localized)
    }
    
    convenience init(message: String) {
        self.init(title: "alertErrorTitle".localized, message: message)
    }
    
    private init(title: String, message: String) {
        self.message = message
        self.title = title
    }
}
