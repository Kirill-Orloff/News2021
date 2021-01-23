//
//  ArticleDate+DateFormatter.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Foundation

struct ArticleDate {
    
    static func publishedDate(from string: String) -> Date? {
        DateFormatter.defaultDateFormatter.date(from: string)
    }
    
    static func publishedDateString(from date: Date) -> String {
        DateFormatter.publishedDateFormatter.string(from: date)
    }
    
    static func relativeDateString(from date: Date) -> String {
        RelativeDateTimeFormatter.publishedDateFormatter.localizedString(for: date, relativeTo: Date())
    }
}

extension DateFormatter {
    
    static var defaultDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()
    
    static var publishedDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        return dateFormatter
    }()
}

extension RelativeDateTimeFormatter {
    
    static var publishedDateFormatter: RelativeDateTimeFormatter = {
        let dateFormatter = RelativeDateTimeFormatter()
        dateFormatter.unitsStyle = .full
        return dateFormatter
    }()
}
