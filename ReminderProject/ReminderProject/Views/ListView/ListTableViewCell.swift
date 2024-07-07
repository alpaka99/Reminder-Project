//
//  ListTableViewCell.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import UIKit

final class ListTableViewCell: BaseTableViewCell {
    private(set) var toggleButton = UIButton()
    private let priority = UILabel()
    private let title = UILabel()
    private let content = UILabel()
    private let dateLabel = UILabel()
    private let tagLabel = UILabel()
    private var attributedContainer = {
        var container = AttributeContainer()
        
        container.strikethroughStyle = .none
        container.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return container
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(toggleButton)
        contentView.addSubview(priority)
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
        
        priority.snp.makeConstraints {
            $0.leading.equalTo(toggleButton.snp.trailing)
                .offset(8)
            $0.centerY.equalTo(toggleButton.snp.centerY)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(priority.snp.trailing)
                .offset(8)
            $0.trailing.lessThanOrEqualTo(contentView)
                .offset(-8)
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
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "circle")
        toggleButton.configuration = config
        
        priority.font = .systemFont(ofSize: 16, weight: .semibold)
        priority.textColor = .white
        
        
        content.font = .systemFont(ofSize: 12, weight: .medium)
        content.textColor = .systemGray4
        
        
        dateLabel.font = .systemFont(ofSize: 12, weight: .medium)
        dateLabel.textColor = .systemGray4
        
        
        tagLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        tagLabel.textColor = .systemBlue
    }
    
    internal func configureData(_ data: Todo) {
        content.text = data.content
        dateLabel.text = DateHelper.shared.string(from: data.dueDate)
        if let priorityInt = data.priority, let priorityEmoji = TodoPriority.init(rawValue: priorityInt)?.emoji {
            priority.text = priorityEmoji
        }
        tagLabel.text = data.tag
        
        setToggleButton(data)
        setAttributeText(data)
    }
    
    private func setToggleButton(_ data: Todo) {
        guard var config = toggleButton.configuration else { return }
        if data.completed {
            config.image = UIImage(systemName: "checkmark.circle.fill")
            toggleButton.configuration = config
        } else {
            config.image = UIImage(systemName: "circle")
            toggleButton.configuration = config
        }
    }
    
    private func setAttributeText(_ data: Todo) {
        let attributeString = NSMutableAttributedString(string: data.title)
        attributeString.addAttribute(.foregroundColor, value: UIColor.white, range: NSMakeRange(0, attributeString.length))
        
        if data.completed {
            attributeString.addAttribute(
                .strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSMakeRange(
                    0,
                    attributeString.length
                ))
        }
        
        title.attributedText = attributeString
    }
}
