//
//  SettingsVC.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Reusable
import SnapKit

protocol SettingsDelegate: class {
    
    func settingsWasUpdated()
}

class SettingsVC: UIViewController {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .mainBackgroundColor
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Vars
    weak var delegate: SettingsDelegate?
    private let settingsType: SettingsType
    
    // MARK: - Inits
    init(settingsType: SettingsType) {
        self.settingsType = settingsType
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        initUI()
    }
    
    // MARK: - Private
    private func initUI() {
        setupSubviews()
        setupConstraints()
        setupNavBar()
        registerCells()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavBar() {
        title = settingsType.settingsTitle
        navigationController?.navigationBar.tintColor = .mainTextColor
    }
    
    private func registerCells() {
        tableView.register(cellType: SettingsCountryCell.self)
        tableView.register(cellType: SettingsCategoryCell.self)
    }
}

// MARK: - UITableViewDataSource
extension SettingsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingsType == .categories ? Category.allCases.count : Country.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        settingsType == .categories ?
            categoryCell(indexPath: indexPath, category: Category.allCases[indexPath.row]) :
            countryCell(indexPath: indexPath, country: Country.allCases[indexPath.row])
    }
}

// MARK: - UITableViewCells
extension SettingsVC {
    
    private func categoryCell(indexPath: IndexPath, category: Category) -> UITableViewCell {
        let cell: SettingsCategoryCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupWith(category: category)
        return cell
    }
    
    private func countryCell(indexPath: IndexPath, country: Country) -> UITableViewCell {
        let cell: SettingsCountryCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupWith(country: country)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if settingsType == .categories {
            Settings.selectedCategory = Category.allCases[indexPath.row]
        } else {
            Settings.selectedCountry = Country.allCases[indexPath.row]
        }
        delegate?.settingsWasUpdated()
        navigationController?.popViewController(animated: true)
    }
}
