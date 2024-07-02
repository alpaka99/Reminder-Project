//
//  RegisterViewCell.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class RegisterDisclosureCell: BaseView {
    private let title = UILabel()
    private let trailingButton = UIButton()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(title)
        self.addSubview(trailingButton)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        title.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
                .offset(16)
            $0.verticalEdges.equalTo(self.snp.verticalEdges)
                .inset(16)
        }
        
        trailingButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.snp.verticalEdges)
                .inset(16)
            $0.trailing.equalTo(self.snp.trailing)
                .inset(16)
            $0.width.equalTo(trailingButton.snp.height)
                .multipliedBy(1)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        title.text = "타이틀"
        title.textColor = .systemGray4
        title.font = .systemFont(ofSize: 16, weight: .semibold)
        
        trailingButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        trailingButton.tintColor = .systemGray4
    }
    
    func configureData(_ type: RegisterFieldType) {
        title.text = type.title
    }
}
