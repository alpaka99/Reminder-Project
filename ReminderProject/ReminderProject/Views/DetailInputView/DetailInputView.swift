//
//  DetailInputView.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//

import UIKit

import SnapKit

final class DetailInputView: BaseView {
    var type: RegisterFieldType?
    
    let datePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        
        datePicker.backgroundColor = .white
        datePicker.alpha = 0
        datePicker.layer.cornerRadius = 8
        
        return datePicker
    }()
    
    let textField = {
        let textField = UITextField()
        
        textField.backgroundColor = .darkGray
        textField.layer.cornerRadius = 8
        textField.placeholder = "태그를 입력해주세요"
        textField.alpha = 0
        
        return textField
    }()
    
    let segmentedControl = {
        let segmentedControl = UISegmentedControl(items: TodoPriority.allContents)
        
        segmentedControl.backgroundColor = .darkGray
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.alpha = 0
        
        return segmentedControl
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(datePicker)
        self.addSubview(textField)
        self.addSubview(segmentedControl)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        datePicker.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.width.equalTo(self.snp.width)
                .multipliedBy(0.8)
        }
        
        textField.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.width.equalTo(self.snp.width)
                .multipliedBy(0.8)
            $0.height.equalTo(50)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.width.equalTo(self.snp.width)
                .multipliedBy(0.8)
            $0.height.equalTo(50)
        }
    }
    
    
    internal func configureData(_ type: RegisterFieldType) {
        self.type = type
        
        switch type {
        case .dueDate:
            datePicker.alpha = 1
        case .tag:
            textField.alpha = 1
        case .priority:
            segmentedControl.alpha = 1
        case .image:
            break
        }
    }
    
    internal func sendDetailData() -> String {
        guard let type = type else { return "" }
        switch type {
        case .dueDate:
            guard let date = DateHelper.shared.string(from: datePicker.date) else { return "" }
            return date
        case .tag:
            if let text = textField.text, !text.isEmpty {
                return "#" + text
            }
        case .priority:
            return TodoPriority.init(rawValue: segmentedControl.selectedSegmentIndex)?.content ?? ""
        case .image:
            return "Wrong Access to DetailInputView"
        }
        
        return ""
    }
}
