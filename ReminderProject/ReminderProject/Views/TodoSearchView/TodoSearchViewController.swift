//
//  TodoSearchViewController.swift
//  ReminderProject
//
//  Created by user on 7/9/24.
//

import UIKit

final class TodoSearchViewController: BaseViewController<TodoSearchView> {
    
    let todos = RealmManager.shared.readAll(Todo.self)
    
    override func configureDelegate() {
        super.configureDelegate()
        
        baseView.searchBar.delegate = self
        
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
        baseView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        baseView.tableView.register(TodoSearchTableViewCell.self, forCellReuseIdentifier: TodoSearchTableViewCell.identifier)
    }
}

extension TodoSearchViewController: UISearchBarDelegate {
    
}


extension TodoSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoSearchTableViewCell.identifier, for: indexPath) as? TodoSearchTableViewCell else { return UITableViewCell() }
        
        let data = todos[indexPath.row]
        
        cell.titleLabel.text = data.title
        
        cell.subTitleLabel.text = data.category.first?.categoryName
        
        return cell
    }
    
    
}
