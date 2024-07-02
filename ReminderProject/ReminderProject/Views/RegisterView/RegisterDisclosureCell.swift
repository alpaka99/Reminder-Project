//
//  RegisterViewCell.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class RegisterDisclosureCell: BaseCollectionViewCell {
    let title = UILabel()
    let trailingButton = UIButton()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(title)
        contentView.addSubview(trailingButton)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        title.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading)
                .offset(8)
            $0.verticalEdges.equalTo(contentView.snp.verticalEdges)
                .inset(8)
        }
        
        trailingButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView.snp.verticalEdges)
                .inset(8)
            $0.trailing.equalTo(contentView.snp.trailing)
                .inset(8)
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
        title.font = .systemFont(ofSize: 12, weight: .semibold)
        
        trailingButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    }
}
