//
//  ListView.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import UIKit

import SnapKit

final class ListView: BaseView {
    let titleLabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    let tableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(titleLabel)
        self.addSubview(tableView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
                .inset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(16)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func configureData(_ text: String) {
        titleLabel.text = text
    }
}
