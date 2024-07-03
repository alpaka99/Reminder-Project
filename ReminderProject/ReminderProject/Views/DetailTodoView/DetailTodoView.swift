//
//  DetailTodoView.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//

import UIKit

import SnapKit

final class DetailTodoView: BaseView {
    private let titleLabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private let contentLebl = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private let dueDateLabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private let tagLabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private let priorityLabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    private lazy var stackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            contentLebl,
            dueDateLabel,
            tagLabel,
            priorityLabel
        ])
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private var todo: Todos
    
    init(todo: Todos) {
        self.todo = todo
        
        super.init(frame: .zero)
        
        
    }
    
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(stackView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        stackView.snp.makeConstraints {
            $0.center.equalTo(self)
                .inset(16)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        titleLabel.text = todo.title
        contentLebl.text = todo.content
        dueDateLabel.text = DateHelper.shared.string(from: todo.dueDate)
        tagLabel.text = todo.tag
        priorityLabel.text = String(describing: todo.priority)
    }
}
