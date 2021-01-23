//
//  SettingsCategoryCell.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import SnapKit

class SettingsCategoryCell: BaseCell {
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Internal
    override func initUI() {
        super.initUI()
        setupSubviews()
        setupConstraints()
    }
    
    func setupWith(category: Category) {
        titleLabel.text = category.title
    }
    
    // MARK: - Private
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.inset)
        }
    }
}

// MARK: - Constants
private extension SettingsCategoryCell {
    
    struct Constants {
        static let inset: CGFloat = 16
        static let titleLabelFont: UIFont = .systemFont(ofSize: 17, weight: .bold)
    }
}
