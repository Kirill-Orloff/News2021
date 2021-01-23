//
//  SettingsCountryCell.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Kingfisher

class SettingsCountryCell: BaseCell {
    
    // MARK: - Views
    private lazy var countryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.countryStackViewInset
        stackView.addArrangedSubview(countryImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Internal
    override func initUI() {
        super.initUI()
        setupSubviews()
        setupConstraints()
    }
    
    func setupWith(country: Country) {
        countryImageView.image = country.image
        titleLabel.text = country.title
    }
    
    // MARK: - Private
    private func setupSubviews() {
        contentView.addSubview(countryStackView)
    }
    
    private func setupConstraints() {
        countryImageView.snp.makeConstraints { make in
            make.size.equalTo(Constants.countryImageViewSize)
        }
        countryStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.inset)
            make.leading.trailing.equalToSuperview().inset(Constants.countryStackViewInset)
        }
    }
}

// MARK: - Constants
private extension SettingsCountryCell {
    
    struct Constants {
        static let inset: CGFloat = 8
        static let countryStackViewInset: CGFloat = 16
        static let titleLabelFont: UIFont = .systemFont(ofSize: 17, weight: .bold)
        static let countryImageViewSize: CGSize = CGSize(width: 44, height: 44)
    }
}
