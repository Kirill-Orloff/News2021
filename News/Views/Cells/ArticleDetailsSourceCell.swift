//
//  ArticleDetailsSourceCell.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import SnapKit

protocol ArticleDetailsSourceCellDelegate: class {
    
    func didTapSourceButton(url: URL)
}

class ArticleDetailsSourceCell: BaseCell {
    
    // MARK: - Views
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.sourceLabelFont
        label.text = "sourceName".localized
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sourceButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Constants.sourceLabelFont
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapSourceButton), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Vars
    private weak var delegate: ArticleDetailsSourceCellDelegate?
    private var sourceUrl: URL?
    
    // MARK: - Internal
    override func initUI() {
        super.initUI()
        setupSubviews()
        setupConstraints()
    }
    
    func setupWith(name: String, url: URL?, delegate: ArticleDetailsSourceCellDelegate) {
        sourceUrl = url
        self.delegate = delegate
        sourceButton.setTitle(name, for: .normal)
        sourceButton.setTitleColor(url == nil ? .mainTextColor : .linkColor, for: .normal)
    }
    
    // MARK: - Private
    private func setupSubviews() {
        contentView.addSubview(sourceLabel)
        contentView.addSubview(sourceButton)
    }
    
    private func setupConstraints() {
        sourceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.inset)
        }
        sourceButton.snp.makeConstraints { make in
            make.centerY.equalTo(sourceLabel.snp.centerY)
            make.leading.equalTo(sourceLabel.snp.trailing).offset(Constants.sourceButtonLeadingInset)
            make.top.trailing.equalToSuperview().inset(Constants.inset)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc
    private func didTapSourceButton() {
        guard let currentSourceUrl = sourceUrl else { return }
        delegate?.didTapSourceButton(url: currentSourceUrl)
    }
}

// MARK: - Constants
private extension ArticleDetailsSourceCell {
    
    struct Constants {
        static let inset: CGFloat = 16
        static let sourceButtonLeadingInset: CGFloat = 4
        static let sourceLabelFont: UIFont = .systemFont(ofSize: 14)
    }
}
