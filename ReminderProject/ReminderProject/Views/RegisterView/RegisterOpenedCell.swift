//
//  RegisterOpenedCell.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class RegisterOpenedCell: BaseCollectionViewCell {
    let textField = UITextField()
    let divider = UIView()
    let textView = UITextView()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(textField)
        contentView.addSubview(divider)
        contentView.addSubview(textView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        textField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView)
                .inset(8)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(textField.snp.bottom)
                .offset(8)
            $0.horizontalEdges.equalTo(textField.snp.horizontalEdges)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
                .offset(8)
            $0.horizontalEdges.equalTo(textField.snp.horizontalEdges)
            $0.bottom.equalTo(contentView)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        textField.placeholder = "제목"
        
        textView.text = "메모"
        textView.textContainer.maximumNumberOfLines = 8
    }
}
