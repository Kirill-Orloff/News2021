//
//  ArticlesListVC.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Reusable
import SnapKit

class ArticlesListVC: UIViewController, AlertPresentable {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView = emptyDataView
        tableView.backgroundColor = .secondaryBackgroundColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .mainTextColor
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didTriggeredRefreshControl), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var emptyDataView: EmptyDataView = {
        EmptyDataView()
    }()
    
    private lazy var firstLaunchHintView: FirstLaunchHintView = {
        let view = FirstLaunchHintView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapFirstLaunchHintView))
        view.addGestureRecognizer(tap)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var openCountiesListBarButton: UIBarButtonItem = barButton(
        title: viewModel.selectedCountry.titleForBarButton,
        action: #selector(didTapOpenCountriesListBarButton)
    )
    
    private lazy var openCategoriesListBarButton: UIBarButtonItem = barButton(
        title: viewModel.selectedCategory.titleForBarButton,
        action: #selector(didTapOpenCategoriesListBarButton)
    )
    
    // MARK: - Vars
    private let viewModel: ArticlesListVM = ArticlesListVM()
    private var state: ArticlesListState = .emptyData {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        initUI()
    }
    
    override func viewDidLoad() {
        updateData()
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
        tableView.addSubview(refreshControl)
        view.addSubview(activityIndicatorView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupNavBar() {
        title = "newsTitle".localized
        navigationController?.navigationBar.barTintColor = .mainBackgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.font: Constants.navBarTitleFont]
        navigationItem.leftBarButtonItem = openCountiesListBarButton
        navigationItem.rightBarButtonItem = openCategoriesListBarButton
    }
    
    private func registerCells() {
        tableView.register(cellType: ArticlesListItemCell.self)
    }
    
    private func updateBarButtonsTitles() {
        openCountiesListBarButton.title = viewModel.selectedCountry.titleForBarButton
        openCategoriesListBarButton.title = viewModel.selectedCategory.titleForBarButton
    }
    
    private func updateData() {
        viewModel.updateDataIfNeeded { [weak self] newState in
            self?.state = newState
        }
    }
    
    private func updateState() {
        switch state {
        case .loading:
            changeEmptyDataViewVisability(visible: false)
            activityIndicatorView.startAnimating()
        case .refreshing:
            changeEmptyDataViewVisability(visible: false)
        case .emptyData:
            stopLoadingIndicators()
            changeEmptyDataViewVisability(visible: true)
        case .content(let needShowFirstLaunchHint):
            stopLoadingIndicators()
            changeEmptyDataViewVisability(visible: false)
            tableView.reloadData()
            guard needShowFirstLaunchHint else { return }
            presentFirstLaunchHintView()
        case .error(let error):
            presentAlert(with: error) { [weak self] in
                self?.stopLoadingIndicators()
            }
        }
    }
    
    private func stopLoadingIndicators() {
        refreshControl.endRefreshing()
        activityIndicatorView.stopAnimating()
    }
    
    private func changeEmptyDataViewVisability(visible: Bool) {
        tableView.backgroundView?.isHidden = !visible
    }
    
    private func presentFirstLaunchHintView() {
        navigationController?.view.addSubview(firstLaunchHintView)
        firstLaunchHintView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func removeFirstLaunchHintView() {
        guard navigationController?.view.subviews.contains(firstLaunchHintView) == true else { return }
        UIView.animate(withDuration: Constants.removeFirstLaunchHintViewAnimationDuration) {
            self.firstLaunchHintView.alpha = 0
        } completion: { _ in
            self.firstLaunchHintView.removeFromSuperview()
        }
    }
    
    private func barButton(title: String, action: Selector) -> UIBarButtonItem {
        let button = UIBarButtonItem(
            title: title,
            style: .plain,
            target: self,
            action: action
        )
        button.setTitleTextAttributes(
            [.foregroundColor: UIColor.mainTextColor ?? .black, .font: Constants.barButtonFont],
            for: .normal
        )
        return button
    }
    
    private func showSettingsVC(type: SettingsType) {
        let settingsVC = SettingsVC(settingsType: type)
        settingsVC.delegate = self
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    // MARK: - Actions
    @objc
    private func didTriggeredRefreshControl() {
        viewModel.reloadData(isRefreshing: true) { [weak self] newState in
            self?.state = newState
        }
    }
    
    @objc
    private func didTapFirstLaunchHintView() {
        removeFirstLaunchHintView()
        Settings.firstLaunchHintWasShowed = true
    }
    
    @objc
    private func didTapOpenCountriesListBarButton() {
        showSettingsVC(type: .countries)
    }
    
    @objc
    private func didTapOpenCategoriesListBarButton() {
        showSettingsVC(type: .categories)
    }
}

// MARK: - UITableViewDataSource
extension ArticlesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articlesViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.articlesViewModels.count > indexPath.row else { return UITableViewCell() }
        let cell: ArticlesListItemCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupWith(viewModel: viewModel.articlesViewModels[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ArticlesListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.articlesViewModels.count > indexPath.row else { return }
        let articleVM = ArticleDetailsVM(article: viewModel.articlesViewModels[indexPath.row].article)
        let articleDetailsVC = ArticleDetailsVC(viewModel: articleVM)
        navigationController?.pushViewController(articleDetailsVC, animated: true)
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension ArticlesListVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard viewModel.isEndOfScroll(nextVisibleIndexPaths: indexPaths) else { return }
        updateData()
    }
}

// MARK: - SettingsVcDelegate
extension ArticlesListVC: SettingsDelegate {
    
    func settingsWasUpdated() {
        viewModel.reloadData(isRefreshing: false) { [weak self] newState in
            self?.state = newState
            self?.updateBarButtonsTitles()
            self?.tableView.scrollToTop()
        }
    }
}

// MARK: - Constants
private extension ArticlesListVC {
    
    struct Constants {
        static let barButtonFont: UIFont = .systemFont(ofSize: 16, weight: .bold)
        static let navBarTitleFont: UIFont = .systemFont(ofSize: 18, weight: .bold)
        static let removeFirstLaunchHintViewAnimationDuration: TimeInterval = 0.1
    }
}
