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
    @Persisted var createdAt: Date
    
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted(indexed: true) var category: String
    @Persisted var dueDate: Date?
    @Persisted var priority: Int?
    @Persisted var tag: String?
    
    
    convenience init(
        createdAt: Date = Date.now,
        title: String,
        content: String? = nil,
        category: String,
        dueDate: Date? = nil,
        tag: String? = nil,
        priority: Int? = nil
    ) {
        self.init()
        
        self.createdAt = createdAt
        
        self.title = title
        self.content = content
        self.category = category
        self.dueDate = dueDate
        self.tag = tag
        self.priority = priority
    }
}
