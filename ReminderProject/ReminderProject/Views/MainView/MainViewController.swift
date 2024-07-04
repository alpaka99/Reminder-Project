//
//  MainViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import RealmSwift

final class MainViewController: BaseViewController<MainView> {
    private var categories = TodoCategory.allCases
    private var totalTodos = RealmManager.shared.readAll(Todo.self)
    private lazy var todayTodos: Results<Todo> = totalTodos.where {
        // MARK: 오늘날짜와 비교하는 로직 필요
        $0.dueDate == Date.now
    }
    private lazy var scheduledTodos: Results<Todo> = totalTodos.where {
        $0.dueDate > Date.now
    }
    private lazy var flagedTodos: Results<Todo> = totalTodos.where {
        $0.flaged == true
    }
    private lazy var completedTodos: Results<Todo> = totalTodos.where {
        $0.completed == true
    }
    
    private lazy var leftBarButton = UIBarButtonItem(
        image: UIImage(systemName: "calendar.badge.clock"),
        style: .plain,
        target: self,
        action: #selector(leftBarButtonTapped)
    )
    
    private lazy var rightBarbutton = UIBarButtonItem(
        image: UIImage(systemName: "ellipsis.circle"),
        style: .plain,
        target: self,
        action: #selector(rightBarButtonTapped)
    )
    
    override func configureUI() {
        super.configureUI()
        
        navigationItem.rightBarButtonItem = rightBarbutton
    }
    
    @objc
    func leftBarButtonTapped() {
        
    }
    
    @objc func rightBarButtonTapped() {
        print(#function)
    }
    
    override func configureDelegate() {
        super.configureDelegate()
        
        baseView.collectionView.delegate = self
        baseView.collectionView.dataSource = self
        baseView.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        
        baseView.newTodoButton.addTarget(
            self,
            action: #selector(newTodoButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    func newTodoButtonTapped() {
        let registerViewController = RegisterViewController(baseView: RegisterView())
        
        registerViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: registerViewController)
        NavigationManager.shared.presentVC(navigationController)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        let type = categories[indexPath.row]
        cell.configureData(type, count: 10)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let category = categories[indexPath.row]
        
        let listViewController = ListViewController(
            baseView: ListView(),
            category: category
        )
        
        listViewController.delegate = self
        
        NavigationManager.shared.pushVC(listViewController)
            
    }
}

extension MainViewController: RegisterViewControllerDelegate {
    func saveButtonTapped() {
        baseView.collectionView.reloadData()
    }
}

extension MainViewController: ListViewControllerDelegate {
    func deleteButtonTapped() {
        baseView.collectionView.reloadData()
    }
}

protocol ListViewControllerDelegate: AnyObject {
    func deleteButtonTapped()
}
