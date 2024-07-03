//
//  ListViewController.swift
//  ReminderProject
//
//  Created by user on 7/3/24.
//

import UIKit

final class ListViewController: BaseViewController<ListView> {
    private lazy var rightBarbutton = UIBarButtonItem(
        image: UIImage(systemName: "ellipsis.circle"),
        style: .plain,
        target: self,
        action: #selector(rightBarButtonTapped)
    )
    
    private var results = RealmManager.shared.readAll(Todos.self)
    
    override func configureUI() {
        super.configureUI()
        
        navigationItem.rightBarButtonItem = rightBarbutton
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
            title: "카테고리 순",
            style: .default
        ) {[weak self] _ in
            self?.results = self?.results?.sorted(
                byKeyPath: "category",
                ascending: true
            )
            self?.baseView.tableView.reloadData()
        }
        let titleSort = UIAlertAction(
            title: "이름 순",
            style: .default
        ) { [weak self] _ in
            self?.results = self?.results?.sorted(
                byKeyPath: "title",
                ascending: true
            )
            self?.baseView.tableView.reloadData()
        }
        let memoSort = UIAlertAction(
            title: "마감일 순",
            style: .default
        ) { [weak self] _ in
            self?.results = self?.results?.sorted(
                byKeyPath: "dueDate",
                ascending: true
            )
            self?.baseView.tableView.reloadData()
        }
        
        ac.addAction(dueDateSort)
        ac.addAction(titleSort)
        ac.addAction(memoSort)
        
        NavigationManager.shared.presentVC(ac, animated: true)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        if let data = results?[indexPath.row] {
            cell.configureData(data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let data = results?[indexPath.row] else { return }
        
        NavigationManager.shared.pushVC(DetailTodoViewController(baseView: DetailTodoView(todo: data)))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let target = results?[indexPath.row]
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "삭제"
        ) { _, _, _ in
            if let target = target {
                RealmManager.shared.delete(target)
                tableView.reloadData()
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
