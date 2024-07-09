//
//  TodoSearchTableViewCell.swift
//  ReminderProject
//
//  Created by user on 7/9/24.
//

import UIKit

import SnapKit

final class TodoSearchTableViewCell: BaseTableViewCell {
    let titleLabel = {
        let label = UILabel()
        
        return label
    }()
    
    let subTitleLabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading)
                .offset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing)
                .offset(-16)
        }
    }
}
