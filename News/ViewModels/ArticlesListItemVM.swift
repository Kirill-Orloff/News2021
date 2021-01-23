//
//  ArticlesListItemVM.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Foundation

struct ArticlesListItemVM {
    
    // MARK: - Vars
    let article: Article
    
    var title: String {
        article.title
    }
    
    var formattedPublishedDate: String {
        guard let publishedDate = article.publishedDate else { return "publishedDateUnknown".localized }
        return ArticleDate.relativeDateString(from: publishedDate)
    }
    
    var imageUrl: URL? {
        article.imageUrl
    }
    
    // MARK: - Inits
    init(article: Article) {
        self.article = article
    }
}
