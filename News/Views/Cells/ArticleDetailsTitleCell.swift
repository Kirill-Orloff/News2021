//
//  ArticleDetailsTitleCell.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import SnapKit

class ArticleDetailsTitleCell: BaseCell {
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleLabelFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Internal
    override func initUI() {
        super.initUI()
        setupSubviews()
        setupConstraints()
    }
    
    func setupWith(title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(Constants.inset)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Constants
private extension ArticleDetailsTitleCell {
    
    struct Constants {
        static let inset: CGFloat = 16
        static let titleLabelFont: UIFont = .systemFont(ofSize: 18, weight: .medium)
    }
}
