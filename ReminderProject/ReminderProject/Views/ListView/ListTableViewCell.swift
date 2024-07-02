//
//  ListTableViewCell.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import UIKit

final class ListTableViewCell: BaseTableViewCell {
    private let toggleButton = UIButton()
    private let title = UILabel()
    private let content = UILabel()
    private let dateLabel = UILabel()
    private let tagLabel = UILabel()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(toggleButton)
        contentView.addSubview(title)
        contentView.addSubview(content)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
    }
    
    
    override func configureLayout() {
        super.configureLayout()
        
        toggleButton.snp.makeConstraints {
            $0.top.leading.equalTo(self.contentView)
                .inset(8)
            $0.width.equalTo(contentView.snp.width)
                .multipliedBy(0.1)
            $0.height.equalTo(toggleButton.snp.width)
                .multipliedBy(1)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(toggleButton.snp.trailing)
                .offset(8)
            $0.trailing.equalTo(contentView)
                .offset(8)
            $0.centerY.equalTo(toggleButton.snp.centerY)
        }
        
        content.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom)
                .offset(8)
            $0.horizontalEdges.equalTo(title.snp.horizontalEdges)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(content.snp.bottom)
                .offset(8)
            $0.leading.equalTo(content.snp.leading)
            $0.bottom.equalTo(contentView)
                .offset(-8)
        }
        
        tagLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing)
                .offset(4)
            $0.centerY.equalTo(dateLabel.snp.centerY)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .clear
        
        toggleButton.setImage(UIImage(systemName: "circle"), for: .normal)
        
        title.text = "키보드 구매"
        title.font = .systemFont(ofSize: 16, weight: .semibold)
        title.textColor = .white
        
        content.text = "예쁜 키캡 알아보기"
        content.font = .systemFont(ofSize: 12, weight: .medium)
        content.textColor = .systemGray4
        
        dateLabel.text = Date.now.formatted()
        dateLabel.font = .systemFont(ofSize: 12, weight: .medium)
        dateLabel.textColor = .systemGray4
        
        tagLabel.text = "#쇼핑"
        tagLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        tagLabel.textColor = .systemBlue
    }
}
