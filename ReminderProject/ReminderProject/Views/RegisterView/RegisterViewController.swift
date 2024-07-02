//
//  RegisterViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

final class RegisterViewController: BaseViewController {
    let registerFieldTypes: [RegisterFieldType] = RegisterFieldType.allCases
}

extension RegisterViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
