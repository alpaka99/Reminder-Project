//
//  Observable.swift
//  ReminderProject
//
//  Created by user on 7/10/24.
//

import Foundation

final class Observable<T> {
    
    var closure: ((T) -> Void)?
    
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T)->Void) {
        self.closure = closure
    }
    
    func actionClosure(_ closure: @escaping (T)->Void) {
        closure(value)
        self.closure = closure
    }
}
