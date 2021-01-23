//
//  BaseTargetType.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {
    
    var baseURL: URL {
        URL(string: "https://newsapi.org/v2")!
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        ["X-Api-Key": "ed08d78b9f904540b72a025145be41bb"]
    }
}
