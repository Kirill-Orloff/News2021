//
//  KeyedDecodingContainer+Decode.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

extension KeyedDecodingContainer {
    
    // MARK: - Internal
    func decode<T: Decodable>(_ key: Key, as type: T.Type = T.self) throws -> T {
        try self.decode(T.self, forKey: key)
    }
}
