//
//  Article.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Foundation

struct Article: Codable {
    
    // MARK: - Vars
    let source: String
    let title: String
    let url: URL?
    let imageUrl: URL?
    let content: String?
    private(set) var publishedDate: Date?
    
    private enum CodingKeys: String, CodingKey {
        case source
        case title
        case url
        case imageUrl = "urlToImage"
        case content = "description"
        case publishedDate = "publishedAt"
    }
    
    private enum SourceCodingKeys: String, CodingKey {
        case name
    }
    
    // MARK: - Inits
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sourceContainer = try container.nestedContainer(keyedBy: SourceCodingKeys.self, forKey: .source)
        source = try sourceContainer.decode(.name)
        title = try container.decode(.title)
        url = try? container.decode(.url)
        imageUrl = try? container.decode(.imageUrl)
        content = try? container.decode(.content)
        if let stringPublishedDate = try? container.decode(.publishedDate, as: String.self) {
            publishedDate = ArticleDate.publishedDate(from: stringPublishedDate)
        }
    }
}
