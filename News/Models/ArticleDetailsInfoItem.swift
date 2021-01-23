//
//  ArticleDetailsInfoItem.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Foundation

enum ArticleDetailsInfoItem {
    
    case image(url: URL)
    case title(_ : String)
    case publishedDate(_ : String)
    case source(name: String, url: URL?)
    case content(_ : String)
}
