//
//  Storage.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Foundation

@propertyWrapper
struct Storage<T: Codable> {
    
    // MARK: - Vars
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data else { return defaultValue }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key.rawValue)
        }
    }
    
    private let key: StorageKey
    private let defaultValue: T
    
    // MARK: - Inits
    init(key: StorageKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
