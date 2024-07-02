//
//  MainCollectionCell.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class MainCollectionCell: BaseCollectionViewCell {
    let iconBackground = UIView()
    let icon = UIImageView()
    let title = UILabel()
    let number = UILabel()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(iconBackground)
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(number)
    }
    
    
    override func configureLayout() {
        super.configureLayout()
        
        iconBackground.snp.makeConstraints {
            $0.top.leading.equalTo(contentView)
                .inset(8)
            $0.width.equalTo(contentView.snp.height)
                .multipliedBy(0.5)
            $0.width.equalTo(iconBackground.snp.height)
                .multipliedBy(1)
        }
        
        icon.snp.makeConstraints {
            $0.edges.equalTo(iconBackground)
                .inset(8)
            $0.width.equalTo(icon.snp.height)
                .multipliedBy(1)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(iconBackground.snp.bottom)
                .offset(8)
            $0.centerX.equalTo(iconBackground.snp.centerX)
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
        
        backgroundColor = .systemGray.withAlphaComponent(0.3)
        
        icon.clipsToBounds = true
        
        title.font = .systemFont(ofSize: 16, weight: .medium)
        title.textColor = .systemGray5
        
        number.font = .systemFont(ofSize: 28, weight: .bold)
        number.textColor = .white
    }
    
    internal func configureData(_ type: TodoCategory) {
        iconBackground.backgroundColor = type.backgroundColor
        icon.image = UIImage(systemName: type.systemName)
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        
        
        title.text = type.title
        
        number.text = "10"
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        iconBackground.layer.cornerRadius = iconBackground.frame.width / 2
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
}
