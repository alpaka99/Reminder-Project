//
//  RegisterOpenedCell.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class RegisterOpenedCell: BaseView {
    let textField = {
        let textField = UITextField()
        
        var attributedContainer = AttributeContainer()
        attributedContainer.foregroundColor = .systemGray5
        attributedContainer.font = .systemFont(ofSize: 20, weight: .semibold)
        let attributedString = AttributedString("제목", attributes: attributedContainer)
        textField.attributedPlaceholder = NSAttributedString(attributedString)
        textField.textColor = .white
        
        return textField
    }()
    
    private let divider = {
        let view = UIView()
        
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    let textView = {
        let textView = UITextView()
        
        textView.backgroundColor = .darkGray
        textView.text = "메모"
        textView.textColor = .systemGray4
        textView.font = .systemFont(ofSize: 18)
        textView.textContainer.maximumNumberOfLines = 8
        
        return textView
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(textField)
        self.addSubview(divider)
        self.addSubview(textView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        textField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self)
                .inset(16)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(textField.snp.bottom)
                .offset(16)
            $0.horizontalEdges.equalTo(textField.snp.horizontalEdges)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
                .offset(16)
            $0.horizontalEdges.equalTo(textField.snp.horizontalEdges)
            $0.height.equalTo(200)
            $0.bottom.equalTo(self)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 8
    }
}
