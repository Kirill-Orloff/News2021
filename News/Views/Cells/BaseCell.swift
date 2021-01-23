//
//  BaseCell.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import UIKit

class BaseCell: UITableViewCell {
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    // MARK: - Internal
    func initUI() {
        setupContentView()
    }
    
    // MARK: - Private
    private func setupContentView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
