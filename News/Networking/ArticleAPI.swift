//
//  ArticleAPI.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Moya

enum ArticleAPI {
    
    case getTopHeadlines(country: Country, category: Category, pageSize: Int, page: Int)
}

// MARK: - BaseTargetType
extension ArticleAPI: BaseTargetType {
    
    var path: String {
        switch self {
        case .getTopHeadlines:
            return "/top-headlines"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTopHeadlines:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getTopHeadlines(country, category, pageSize, page):
            let parameters: [String: Any] = [
                "country": country.urlParam,
                "category": category,
                "pageSize": pageSize,
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
