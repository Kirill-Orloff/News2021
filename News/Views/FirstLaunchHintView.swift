//
//  FirstLaunchHintView.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import SnapKit

class FirstLaunchHintView: UIView {
    
    // MARK: - Views
    private lazy var chooseCountryImageView: UIImageView = hintImageView(image: UIImage(named: "icHintLeftArrow"))
    private lazy var chooseCountryLabel: UILabel = hintLabel(text: "chooseCountryHint".localized)
    
    private lazy var chooseCountryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Constants.hintStackViewSpacing
        stackView.addArrangedSubview(chooseCountryImageView)
        stackView.addArrangedSubview(chooseCountryLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var chooseCategoryImageView: UIImageView = hintImageView(image: UIImage(named: "icHintRightArrow"))
    private lazy var chooseCategoryLabel: UILabel = hintLabel(text: "chooseCategoryHint".localized)
    
    private lazy var chooseCategoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = Constants.hintStackViewSpacing
        stackView.addArrangedSubview(chooseCategoryImageView)
        stackView.addArrangedSubview(chooseCategoryLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var readNewsLabel: UILabel = hintLabel(text: "readNewsHint".localized)
    private lazy var readNewsImageView: UIImageView = hintImageView(image: UIImage(named: "icHintBottomArrow"))
    
    private lazy var readNewsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.hintStackViewSpacing
        stackView.addArrangedSubview(readNewsLabel)
        stackView.addArrangedSubview(readNewsImageView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }
    
    // MARK: - Private
    private func initUI() {
        setupContentView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupContentView() {
        backgroundColor = .hintBackgroundColor
    }
    
    private func setupSubviews() {
        addSubview(chooseCountryStackView)
        addSubview(chooseCategoryStackView)
        addSubview(readNewsStackView)
    }
    
    private func setupConstraints() {
        chooseCountryImageView.snp.makeConstraints { make in
            make.size.equalTo(Constants.hintArrowImageViewSize)
        }
        chooseCountryStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(Constants.settingsHintTopInset)
            make.leading.equalToSuperview().inset(Constants.settingsHintHorizontalInset)
        }
        chooseCategoryImageView.snp.makeConstraints { make in
            make.size.equalTo(Constants.hintArrowImageViewSize)
        }
        chooseCategoryStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(Constants.settingsHintTopInset)
            make.trailing.equalToSuperview().inset(Constants.settingsHintHorizontalInset)
        }
        readNewsImageView.snp.makeConstraints { make in
            make.size.equalTo(Constants.hintArrowImageViewSize)
        }
        readNewsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func hintImageView(image: UIImage?) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func hintLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .hintTextColor
        label.font = Constants.hintLabelFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

// MARK: - Constants
private extension FirstLaunchHintView {
    
    struct Constants {
        static let hintLabelFont: UIFont = .italicSystemFont(ofSize: 20)
        static let hintStackViewSpacing: CGFloat = 10
        static let hintArrowImageViewSize: CGSize = CGSize(width: 34, height: 34)
        static let settingsHintTopInset: CGFloat = 34
        static let settingsHintHorizontalInset: CGFloat = 60
    }
}
