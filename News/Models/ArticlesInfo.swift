//
//  ArticlesInfo.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

struct ArticlesInfo: Codable {
    
    let articles: [Article]
    let totalResults: Int
}
