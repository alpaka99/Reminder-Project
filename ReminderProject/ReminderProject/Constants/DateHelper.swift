//
//  DateHelper.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//

import Foundation

class DateHelper {
    private let dateFormatter = DateFormatter()
    private let dateFormat = "yyyy.MM.dd"
    static let shared = DateHelper()
    
    
    init() {
        dateFormatter.dateFormat = dateFormat
    }
    
    func date(from text: String) -> Date? {
        return dateFormatter.date(from: text)
    }
    
    func string(from date: Date?) -> String? {
        guard let date = date else { return nil }
        return dateFormatter.string(from: date)
    }
}
