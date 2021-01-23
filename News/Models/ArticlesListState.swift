//
//  ArticlesListState.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

enum ArticlesListState {
    
    case loading
    case refreshing
    case emptyData
    case content(needShowFirstLaunchHint: Bool)
    case error(error: PresentableError)
}
