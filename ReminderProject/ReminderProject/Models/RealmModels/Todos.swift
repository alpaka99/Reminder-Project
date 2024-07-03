//
//  Todos.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import Foundation

import RealmSwift

final class Todos: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted(indexed: true) var category: String
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var dueDate: Date?
    @Persisted var createdAt: Date
    
    convenience init(
        title: String,
        category: String,
        content: String? = nil,
        dueDate: Date? = nil,
        createdAt: Date = Date.now
    ) {
        self.init()
        
        self.title = title
        self.category = category
        self.content = content
        self.dueDate = dueDate
        self.createdAt = createdAt
    }
}
