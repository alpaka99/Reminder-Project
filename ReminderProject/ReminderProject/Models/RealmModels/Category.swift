//
//  Category.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//

import RealmSwift

// TODO: Add RelationShip to Todo Table
final class Category: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var categoryName: String
    @Persisted var iconName: String
    @Persisted var backgroundColor: String
}
