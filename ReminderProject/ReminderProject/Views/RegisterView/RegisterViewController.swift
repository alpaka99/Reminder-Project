//
//  RegisterViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

final class RegisterViewController: BaseViewController {
    private let registerFieldTypes: [RegisterFieldType] = RegisterFieldType.allCases
    
    private lazy var leftBarButton = {
        let barButton = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        return barButton
    }()
    
    private lazy var rightBarButton = {
        let barButton = UIBarButtonItem(
            title: "추가",
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        barButton.isEnabled = false
        return barButton
    }()
    
    override func configureUI() {
        super.configureUI()
        
        navigationItem.title = "새로운 할 일"
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc
    func cancelButtonTapped() {
        NavigationManager.shared.dismiss(animated: true)
    }
    
    // MARK: Fetch TextField from baseView
    @objc
    func addButtonTapped() {
        RealmManager.shared.create(Todos(
            category: "전체",
            title: "test",
            content: "내용"
        ))
        NavigationManager.shared.dismiss(animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty == true {
            rightBarButton.isEnabled = false
        }
         else {
            rightBarButton.isEnabled = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty == true {
            rightBarButton.isEnabled = false
        }
         else {
            rightBarButton.isEnabled = true
        }
        
    }
}

extension RegisterViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
