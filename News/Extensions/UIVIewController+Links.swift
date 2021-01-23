//
//  UIVIewController+Links.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import UIKit

protocol LinksOpenable: AlertPresentable {
    
    func openUrl(_ url: URL)
}

extension LinksOpenable where Self: UIViewController {
    
    func openUrl(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let error = PresentableError(message: "alertCantOpenLinkError".localized)
            presentAlert(with: error)
        }
    }
}
