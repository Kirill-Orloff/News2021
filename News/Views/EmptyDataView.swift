//
//  EmptyDataView.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import SnapKit

class EmptyDataView: UIView {
    
    // MARK: - Views
    private lazy var emptyDataLabel: UILabel = {
        let label = UILabel()
        label.text = "emptyData".localized
        label.textAlignment = .center
        label.font = Constants.emptyDataLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(emptyDataLabel)
    }
    
    private func setupConstraints() {
        emptyDataLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Constants
private extension EmptyDataView {
    
    struct Constants {
        static let emptyDataLabelFont: UIFont = .systemFont(ofSize: 20)
    }
}
