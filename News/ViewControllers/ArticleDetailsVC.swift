//
//  ArticleDetailsVC.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Reusable
import SnapKit

class ArticleDetailsVC: UIViewController, LinksOpenable {
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .mainBackgroundColor
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Vars
    private let viewModel: ArticleDetailsVM
    
    // MARK: - Inits
    init(viewModel: ArticleDetailsVM) {
        self.viewModel = viewModel
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
        title = viewModel.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .mainTextColor
    }
    
    private func registerCells() {
        tableView.register(cellType: ArticleDetailsImageCell.self)
        tableView.register(cellType: ArticleDetailsTitleCell.self)
        tableView.register(cellType: ArticleDetailsDateCell.self)
        tableView.register(cellType: ArticleDetailsSourceCell.self)
        tableView.register(cellType: ArticleDetailsContentCell.self)
    }
}

// MARK: - UITableViewDataSource
extension ArticleDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.items.count > indexPath.row else { return UITableViewCell() }
        switch viewModel.items[indexPath.row] {
        case .image(let url):
            return imageCell(indexPath: indexPath, url: url)
        case .title(let title):
            return titleCell(indexPath: indexPath, title: title)
        case .publishedDate(let publishedDate):
            return publishedDateCell(indexPath: indexPath, publishedDate: publishedDate)
        case .source(let name, let url):
            return sourceCell(indexPath: indexPath, name: name, url: url)
        case .content(let content):
            return contentCell(indexPath: indexPath, content: content)
        }
    }
}

// MARK: - UITableViewCells
extension ArticleDetailsVC {
    
    private func imageCell(indexPath: IndexPath, url: URL) -> UITableViewCell {
        let cell: ArticleDetailsImageCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupWith(url: url)
        return cell
    }
    
    private func titleCell(indexPath: IndexPath, title: String) -> UITableViewCell {
        let cell: ArticleDetailsTitleCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupWith(title: title)
        return cell
    }
    
    private func publishedDateCell(indexPath: IndexPath, publishedDate: String) -> UITableViewCell {
        let cell: ArticleDetailsDateCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupWith(publishedDate: publishedDate)
        return cell
    }
    
    private func sourceCell(indexPath: IndexPath, name: String, url: URL?) -> UITableViewCell {
        let cell: ArticleDetailsSourceCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupWith(name: name, url: url, delegate: self)
        return cell
    }
    
    private func contentCell(indexPath: IndexPath, content: String) -> UITableViewCell {
        let cell: ArticleDetailsContentCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupWith(content: content)
        return cell
    }
}

// MARK: - ArticleDetailsSourceCellDelegate
extension ArticleDetailsVC: ArticleDetailsSourceCellDelegate {
    
    func didTapSourceButton(url: URL) {
        openUrl(url)
    }
}
