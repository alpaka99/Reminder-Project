//
//  Reusable.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//
import UIKit

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}


extension UICollectionViewCell: Reusable { }
extension UITableViewCell: Reusable { }
