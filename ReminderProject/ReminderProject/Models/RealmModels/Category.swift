//
//  Category.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//
import UIKit

import RealmSwift

final class Category: Object {
    @Persisted(primaryKey: true) var categoryName: String
    @Persisted var iconName: String
    @Persisted var backgroundColor: String
    @Persisted var todos: List<Todo>
    
    convenience init(
        categoryName: String,
        iconName: String,
        backgroundColor: String
    ) {
        self.init()
        
        self.categoryName = categoryName
        self.iconName = iconName
        self.backgroundColor = backgroundColor
    }
}

