//
//  ViewController+Extension.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String? = nil, action: @escaping ()->()) {
        let ac = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            action()
        }
        
        ac.addAction(action)
        
        NavigationManager.shared.presentVC(ac, animated: true)
    }
}
