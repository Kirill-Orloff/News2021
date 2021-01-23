//
//  ArticleDetailsImageCell.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Kingfisher

class ArticleDetailsImageCell: BaseCell {
    
    // MARK: - Views
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icArticlePlaceholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Internal
    override func initUI() {
        super.initUI()
        setupSubviews()
        setupConstraints()
    }
    
    func setupWith(url: URL) {
        articleImageView.kf.setImage(with: url, placeholder: UIImage(named: "icArticlePlaceholder"))
    }
    
    // MARK: - Private
    private func setupSubviews() {
        contentView.addSubview(articleImageView)
    }
    
    private func setupConstraints() {
        articleImageView.snp.makeConstraints { make in
            make.height.equalTo(Constants.articleImageViewHeight)
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Constants
private extension ArticleDetailsImageCell {
    
    struct Constants {
        static let articleImageViewHeight: CGFloat = 200
    }
}
