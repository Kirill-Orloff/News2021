//
//  UITableView+Scrolling.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import UIKit

extension UITableView {
    
    // MARK: - Internal
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        guard hasRow(at: indexPath) else { return }
        scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    // MARK: - Private
    private func hasRow(at indexPath: IndexPath) -> Bool {
        indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }
}
