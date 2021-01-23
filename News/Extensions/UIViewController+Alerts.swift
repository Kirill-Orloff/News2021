//
//  UIViewController+Alerts.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import UIKit

protocol AlertPresentable {
    
    func presentAlert(with error: PresentableError, action: (() -> ())?)
}

extension AlertPresentable where Self: UIViewController {
    
    // MARK: - Internal
    func presentAlert(with error: PresentableError, action: (() -> ())? = nil) {
        let alertController = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "alertDismissActionTitle".localized, style: .default) { _ in
            action?()
        }
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
