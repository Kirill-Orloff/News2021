//
//  ArticleDetailsVM.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

struct ArticleDetailsVM {
    
    // MARK: - Vars
    let title: String
    private(set) var items: [ArticleDetailsInfoItem] = []
    
    // MARK: - Inits
    init(article: Article) {
        title = article.title
        setupItems(article: article)
    }
    
    // MARK: - Private
    private mutating func setupItems(article: Article) {
        if let imageUrl = article.imageUrl {
            items.append(.image(url: imageUrl))
        }
        
        items.append(.title(article.title))
        
        if let publishedDate = article.publishedDate {
            let formattedPublishedDate = ArticleDate.publishedDateString(from: publishedDate)
            items.append(.publishedDate(formattedPublishedDate))
        }
        
        items.append(.source(name: article.source, url: article.url))
        
        if let content = article.content,
           !content.isEmpty {
            items.append(.content(content))
        }
    }
}
