//
//  TodoSearchView.swift
//  ReminderProject
//
//  Created by user on 7/9/24.
//

import UIKit

import SnapKit

final class TodoSearchView: BaseView {
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(searchBar)
        self.addSubview(tableView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        super.configureUI()
    }
}
