//
//  Todos.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import Foundation

import RealmSwift

final class Todo: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var createdAt: Date = Date.now
    
    @Persisted var title: String
    @Persisted var content: String?
    @Persisted var dueDate: Date?
    @Persisted var priority: Int?
    @Persisted var tag: String?
    @Persisted var flaged: Bool = false
    @Persisted var completed: Bool = false
    
    convenience init(
        title: String,
        content: String? = nil,
        dueDate: Date? = nil,
        tag: String? = nil,
        priority: Int? = nil
    ) {
        self.init()
        
        
        self.title = title
        self.content = content
        self.dueDate = dueDate
        self.tag = tag
        self.priority = priority
    }
}
