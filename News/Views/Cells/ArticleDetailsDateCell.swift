//
//  ArticleDetailsDateCell.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import SnapKit

class ArticleDetailsDateCell: BaseCell {
    
    // MARK: - Views
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayTextColor
        label.font = Constants.publishedDateLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Internal
    override func initUI() {
        super.initUI()
        setupSubviews()
        setupConstraints()
    }
        
    func setupWith(publishedDate: String) {
        dateLabel.text = publishedDate
    }
    
    // MARK: - Private
    private func setupSubviews() {
        contentView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(Constants.inset)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Constants
private extension ArticleDetailsDateCell {
    
    struct Constants {
        static let inset: CGFloat = 16
        static let publishedDateLabelFont: UIFont = .systemFont(ofSize: 14)
    }
}
