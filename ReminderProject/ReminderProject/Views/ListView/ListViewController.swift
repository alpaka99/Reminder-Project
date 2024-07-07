//
//  ListViewController.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import UIKit

import RealmSwift

final class ListViewController: BaseViewController<ListView> {
    private lazy var rightBarbutton = UIBarButtonItem(
        image: UIImage(systemName: "ellipsis.circle"),
        style: .plain,
        target: self,
        action: #selector(rightBarButtonTapped)
    )
    
    private var category: TodoCategory
    private var todos: Results<Todo>
    
    weak var delegate: ListViewControllerDelegate?
    
    init(baseView: ListView, category: TodoCategory, todos: Results<Todo>) {
        self.category = category
        self.todos = todos
        super.init(baseView: baseView)
    }
    
    override func configureUI() {
        super.configureUI()
        
        navigationItem.rightBarButtonItem = rightBarbutton
        baseView.configureData(category)
    }
    
    override func configureDelegate() {
        super.configureDelegate()
        
        baseView.delegate = self
        
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
        baseView.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    @objc
    func rightBarButtonTapped() {
        let ac = UIAlertController(
            title: "정렬",
            message: nil,
            preferredStyle: .actionSheet
        )
        let dueDateSort = UIAlertAction(
            title: "우선순위 순",
            style: .default
        ) {[weak self] _ in
            if let todos = self?.todos.sorted(
                byKeyPath: "priority",
                ascending: true
            ) {
                self?.todos = todos
                self?.baseView.tableView.reloadData()
            }
        }
        let titleSort = UIAlertAction(
            title: "이름 순",
            style: .default
        ) { [weak self] _ in
            if let todos = self?.todos.sorted(
                byKeyPath: "title",
                ascending: true
            ) {
                self?.todos = todos
                self?.baseView.tableView.reloadData()
            }
        }
        let memoSort = UIAlertAction(
            title: "마감일 순",
            style: .default
        ) { [weak self] _ in
            if let todos = self?.todos.sorted(
                byKeyPath: "dueDate",
                ascending: true
            ) {
                self?.todos = todos
                self?.baseView.tableView.reloadData()
            }
        }
        
        ac.addAction(dueDateSort)
        ac.addAction(titleSort)
        ac.addAction(memoSort)
        
        NavigationManager.shared.presentVC(ac, animated: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        let data = todos[indexPath.row]
        cell.configureData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let data = todos[indexPath.row]
        
        NavigationManager.shared.pushVC(DetailTodoViewController(baseView: DetailTodoView(todo: data)))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let target = todos[indexPath.row]
        
        let flagedAction = UIContextualAction(style: .normal, title: "깃발") { [weak self] _, _, _ in
            RealmManager.shared.updateFlaged(from: target)
            self?.delegate?.itemUpdated()
            UIView.animate(withDuration: 0.3) {
                tableView.reloadData()
            }
        }
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "삭제"
        ) { [weak self] _, _, _ in
            RealmManager.shared.delete(target)
            self?.delegate?.itemUpdated()
            UIView.animate(withDuration: 0.3) {
                tableView.reloadData()
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, flagedAction])
    }
}
