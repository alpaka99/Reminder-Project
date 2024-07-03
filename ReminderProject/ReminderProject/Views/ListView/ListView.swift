//
//  ListView.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import UIKit

import SnapKit

final class ListView: BaseView {
    let titleLabel = UILabel()
    let tableView = UITableView()
    
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
    
    
    override func configureUI() {
        super.configureUI()
        
        titleLabel.text = "전체"
        titleLabel.textColor = .systemBlue
        titleLabel.font = .systemFont(ofSize: 40, weight: .bold)
        
        tableView.backgroundColor = .clear
    }
}
