//
//  RealmManager.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    private var realm = try! Realm()
    
    private init() { 
        print(realm.configuration.fileURL)
    }
    
    internal func create<T: Object>(_ data: T) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Realm Create error")
            print(error.localizedDescription)
        }
    }
    
    internal func readAll<T: Object>(_ type: T.Type) -> Results<T> {
        let results = realm.objects(type)
        return results
    }
    
    internal func readOne<T: Object>(_ data: T) -> T? {
        let result = realm.object(ofType: T.self, forPrimaryKey: data.objectSchema.primaryKeyProperty)
        return result
    }
    
    // MARK: Update
    internal func update<T: Object> (with newValue: T) {
        do {
            let target = realm.object(ofType: T.self, forPrimaryKey: newValue.objectSchema.primaryKeyProperty)
            try realm.write {
                realm.add(newValue, update: .modified)
            }
        } catch {
            print("Realm Update Error")
            print(error.localizedDescription)
        }
    }
    
    internal func delete<T: Object>(_ data: T) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("Realm Delete Error")
            print(error.localizedDescription)
        }
    }
}
