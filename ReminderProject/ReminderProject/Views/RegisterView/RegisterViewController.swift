//
//  RegisterViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

final class RegisterViewController: BaseViewController<RegisterView> {
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
    
    override func configureDelegate() {
        super.configureDelegate()
        
        baseView.memoView.textField.addTarget(
            self,
            action: #selector(textFieldTextChanged),
            for: .editingChanged
        )
        
        baseView.memoView.textView.delegate = self
    }
    
    @objc
    func textFieldTextChanged(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            rightBarButton.isEnabled = true
        } else {
            rightBarButton.isEnabled = false
        }
    }
    
    @objc
    func cancelButtonTapped() {
        NavigationManager.shared.dismiss(animated: true)
    }
    
    // MARK: Fetch TextField from baseView
    @objc
    func addButtonTapped() {
        guard let  title = baseView.memoView.textField.text else {
            return
        }
        
        let content = baseView.memoView.textView.text
        
        RealmManager.shared.create(Todos(
            category: "식품",
            title: title,
            content: content
        ))
        NavigationManager.shared.dismiss(animated: true)
    }
}

extension RegisterViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
