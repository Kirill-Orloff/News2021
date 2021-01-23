//
//  ArticlesListItemCell.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Kingfisher

class ArticlesListItemCell: BaseCell {
    
    // MARK: - Views
    private lazy var articleBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.articleBackgroundViewCornerRadius
        view.clipsToBounds = true
        view.backgroundColor = .mainBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icArticlePlaceholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleLabelFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.dateLabelFont
        label.textColor = .grayTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.kf.cancelDownloadTask()
        articleImageView.image = nil
    }
    
    // MARK: - Internal
    override func initUI() {
        super.initUI()
        setupSubviews()
        setupConstraints()
    }
    
    func setupWith(viewModel: ArticlesListItemVM) {
        articleImageView.kf.setImage(with: viewModel.imageUrl, placeholder: UIImage(named: "icArticlePlaceholder"))
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.formattedPublishedDate
    }
    
    // MARK: - Private
    private func setupSubviews() {
        contentView.addSubview(articleBackgroundView)
        articleBackgroundView.addSubview(articleImageView)
        articleBackgroundView.addSubview(titleLabel)
        articleBackgroundView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        articleBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.inset)
        }
        articleImageView.snp.makeConstraints { make in
            make.height.equalTo(Constants.articleImageViewHeight)
            make.top.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(articleImageView.snp.bottom).offset(Constants.inset)
            make.leading.trailing.equalToSuperview().inset(Constants.inset)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.inset)
            make.leading.trailing.bottom.equalToSuperview().inset(Constants.inset)
        }
    }
}

// MARK: - Constants
private extension ArticlesListItemCell {
    
    struct Constants {
        static let inset: CGFloat = 8
        static let articleImageViewHeight: CGFloat = 160
        static let articleBackgroundViewCornerRadius: CGFloat = 10
        static let titleLabelFont: UIFont = .systemFont(ofSize: 18, weight: .medium)
        static let dateLabelFont: UIFont = .systemFont(ofSize: 14)
    }
}
