//
//  ArticlesListVM.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Foundation

class ArticlesListVM {
    
    // MARK: - Vars
    var selectedCountry: Country {
        Settings.selectedCountry
    }
    var selectedCategory: Category {
        Settings.selectedCategory
    }
    private(set) var articlesViewModels: [ArticlesListItemVM] = []
    private(set) var articlesTotalCount: Int = 0
    private(set) var page: Int = 0
    private var articlesIsEmpty: Bool {
        articlesTotalCount == 0 || articlesViewModels.count == 0
    }
    private var needUpdateData: Bool {
        articlesTotalCount == 0 || articlesViewModels.count < articlesTotalCount
    }
    private var needShowFirstLaunchHint: Bool {
        !Settings.firstLaunchHintWasShowed
    }
    private var newContentState: ArticlesListState {
        articlesIsEmpty ? .emptyData : .content(needShowFirstLaunchHint: needShowFirstLaunchHint)
    }
    
    // MARK: - Internal
    func updateDataIfNeeded(applyState: @escaping (ArticlesListState) -> ()) {
        guard needUpdateData else { return }
        let nextPageNumber = page + 1
        applyState(.loading)
        loadPage(with: nextPageNumber) { [weak self] articlesInfo in
            guard let self = self else { return }
            self.page = nextPageNumber
            self.updateViewModels(articlesInfo: articlesInfo, isRefreshing: false)
            applyState(self.newContentState)
        } failure: { [weak self] error in
            guard let self = self else { return }
            applyState(.error(error: self.presentableError(from: error)))
        }
    }
    
    func reloadData(isRefreshing: Bool, applyState: @escaping (ArticlesListState) -> ()) {
        page = 1
        applyState(isRefreshing ? .refreshing : .loading)
        loadPage(with: page) { [weak self] articlesInfo in
            guard let self = self else { return }
            self.updateViewModels(articlesInfo: articlesInfo, isRefreshing: true)
            applyState(self.newContentState)
        } failure: { [weak self] error in
            guard let self = self else { return }
            applyState(.error(error: self.presentableError(from: error)))
        }
    }
    
    func isEndOfScroll(nextVisibleIndexPaths indexPaths: [IndexPath]) -> Bool {
        indexPaths.contains { $0.row >= articlesViewModels.count - 1 }
    }
    
    // MARK: - Private
    private func loadPage(with pageNumber: Int, success: @escaping (ArticlesInfo) -> (), failure: NetworkFailureBlock?) {
        ArticleProvider.shared.getTopHeadlines(
            country: selectedCountry,
            category: selectedCategory,
            pageSize: Constants.pageSize,
            page: pageNumber
        ) { articlesInfo in
            success(articlesInfo)
        } failure: { error in
            failure?(error)
        }
    }
    
    private func updateViewModels(articlesInfo: ArticlesInfo, isRefreshing: Bool) {
        if isRefreshing {
            articlesViewModels = articlesViewModels(from: articlesInfo.articles)
        } else {
            articlesViewModels.append(contentsOf: articlesViewModels(from: articlesInfo.articles))
        }
        articlesTotalCount = articlesInfo.totalResults
    }
    
    private func articlesViewModels(from articles: [Article]) -> [ArticlesListItemVM] {
        var articlesViewModels: [ArticlesListItemVM] = []
        articles.forEach {
            let articleViewModel = ArticlesListItemVM(article: $0)
            articlesViewModels.append(articleViewModel)
        }
        return articlesViewModels
    }
    
    private func presentableError(from error: PresentableError?) -> PresentableError {
        guard let currentError = error else {
            let unknownError = PresentableError()
            return unknownError
        }
        return currentError
    }
}

// MARK: - Constants
private extension ArticlesListVM {
    
    struct Constants {
        static let pageSize: Int = 20
    }
}
