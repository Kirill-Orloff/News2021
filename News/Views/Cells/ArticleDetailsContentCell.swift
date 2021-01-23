//
//  ArticleDetailsContentCell.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import SnapKit

class ArticleDetailsContentCell: BaseCell {
    
    // MARK: - Views
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.contentLabelFont
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
    
    func setupWith(content: String) {
        contentLabel.text = content
    }
    
    // MARK: - Private
    private func setupSubviews() {
        contentView.addSubview(contentLabel)
    }
    
    private func setupConstraints() {
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.inset)
        }
    }
}

// MARK: - Constants
private extension ArticleDetailsContentCell {
    
    struct Constants {
        static let inset: CGFloat = 16
        static let contentLabelFont: UIFont = .systemFont(ofSize: 16)
    }
}
