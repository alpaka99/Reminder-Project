//
//  Todos.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import Foundation

import RealmSwift

class Todos: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted(indexed: true) var category: String
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var createdAt: Date
    
    convenience init(
        category: String,
        title: String,
        content: String? = nil,
        createdAt: Date = Date.now
    ) {
        self.init()
        
        self.category = category
        self.title = title
        self.content = content
        self.createdAt = createdAt
    }
}
