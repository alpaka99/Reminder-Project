//
//  RegisterViewCell.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class RegisterDisclosureCell: BaseView {
    let title = {
        let label = UILabel()
        
        label.textColor = .systemGray4
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    let content = {
        let label = UILabel()
        
        label.textColor = .systemGray4
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    let thumbnailImage = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let trailingButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .systemGray4
        
        return button
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(title)
        self.addSubview(content)
        self.addSubview(thumbnailImage)
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
        
        content.snp.makeConstraints {
            $0.trailing.equalTo(trailingButton.snp.leading)
                .offset(-16)
            $0.verticalEdges.equalTo(self.snp.verticalEdges)
                .inset(16)
        }
        
        thumbnailImage.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.snp.verticalEdges)
                .inset(8)
            $0.trailing.equalTo(content.snp.leading)
                .offset(-16)
            
            $0.size.equalTo(44)
        }
        
        
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
    func configureData(_ text: String) {
        title.text = text
    }
}

protocol DisclosureCellDelegate {
    func trailingButtonTapped()
}
