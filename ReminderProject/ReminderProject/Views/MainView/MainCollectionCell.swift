//
//  MainCollectionCell.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class MainCollectionCell: BaseCollectionViewCell {
    let icon = UIImageView()
    let title = UILabel()
    let number = UILabel()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(number)
    }
    
    
    override func configureLayout() {
        super.configureLayout()
        
        icon.snp.makeConstraints {
            $0.top.leading.equalTo(contentView)
                .inset(8)
            $0.width.equalTo(contentView.snp.height)
                .multipliedBy(0.5)
            $0.width.equalTo(icon.snp.height)
                .multipliedBy(1)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(icon.snp.bottom)
                .offset(8)
            $0.centerX.equalTo(icon.snp.centerX)
            $0.bottom.equalTo(contentView.snp.bottom)
                .offset(-8)
        }
        
        number.snp.makeConstraints {
            $0.verticalEdges.equalTo(icon.snp.verticalEdges)
            $0.trailing.equalTo(contentView.snp.trailing)
                .offset(-8)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        icon.clipsToBounds = true
        
        icon.image = UIImage(systemName: "star.fill")
        icon.backgroundColor = .systemBlue
        
        title.text = "오늘"
        
        number.text = "0"
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        icon.layer.cornerRadius = icon.frame.width / 2
    }
}
