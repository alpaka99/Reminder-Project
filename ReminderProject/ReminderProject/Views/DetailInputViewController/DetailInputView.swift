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
        
        
        datePicker.backgroundColor = .white
        datePicker.alpha = 0
        
        return datePicker
    }()
    
    let textField = {
        let textField = UITextField()
        
        textField.backgroundColor = .darkGray
        textField.layer.cornerRadius = 8
        textField.alpha = 0
        
        return textField
    }()
    
    let segmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["High🔴", "Middle🟡", "Low🟣"])
        
        segmentedControl.backgroundColor = .darkGray
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.alpha = 0
        
        return segmentedControl
    }()
    
    let imagePicker = {
        let label = UILabel()
        
        label.text = "Comming soon..."
        label.alpha = 0
        
        return label
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(datePicker)
        self.addSubview(textField)
        self.addSubview(segmentedControl)
        self.addSubview(imagePicker)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        datePicker.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.height.equalTo(50)
            $0.width.equalTo(self.snp.width)
                .multipliedBy(0.8)
        }
        
        textField.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.height.equalTo(50)
            $0.width.equalTo(self.snp.width)
                .multipliedBy(0.8)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.height.equalTo(50)
            $0.width.equalTo(self.snp.width)
                .multipliedBy(0.8)
        }
        
        imagePicker.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.height.equalTo(50)
            $0.width.equalTo(self.snp.width)
                .multipliedBy(0.8)
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
            imagePicker.alpha = 1
        }
    }
    
    internal func sendDetailData() -> String {
        guard let type = type else { return "" }
        switch type {
        case .dueDate:
            guard let date = DateHelper.shared.string(from: datePicker.date) else { return "" }
            return date
        case .tag:
            if let text = textField.text {
                return text
            }
        case .priority:
            return String(segmentedControl.selectedSegmentIndex)
        case .image:
            return "Comming Soon"
        }
        
        return ""
    }
}
