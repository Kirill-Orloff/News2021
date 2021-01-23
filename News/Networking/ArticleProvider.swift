//
//  ArticleProvider.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Moya

class ArticleProvider: BaseNetwork {
    
    // MARK: - Vars
    static let shared = ArticleProvider()
    private let provider = MoyaProvider<ArticleAPI>()
    
    // MARK: - Internal
    func getTopHeadlines(
        country: Country,
        category: Category,
        pageSize: Int,
        page: Int,
        success: @escaping (ArticlesInfo) -> (),
        failure: NetworkFailureBlock?
    ) {
        let request = ArticleAPI.getTopHeadlines(country: country, category: category, pageSize: pageSize, page: page)
        provider.request(request) { [weak self] result in
            self?.processResponse(result: result, success: success, failure: failure)
        }
    }
}
