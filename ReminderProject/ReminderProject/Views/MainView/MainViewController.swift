//
//  MainViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import Realm
import RealmSwift

final class MainViewController: BaseViewController<MainView> {
    private var categories = TodoCategory.allCases
    private var currentDate = Date.now
    private var totalTodos: Results<Todo> = RealmManager.shared.readAll(Todo.self)
    // https://stackoverflow.com/questions/35964884/how-do-i-filter-events-created-for-the-current-date-in-the-realm-swift/35965216#35965216
    private lazy var todayTodos = totalTodos.where {
        let start = Calendar.current.startOfDay(for: currentDate)
        if let end = Calendar.current.date(byAdding: .day, value: 1, to: start) {
            return $0.dueDate >= start && $0.dueDate < end
        }
        return $0.dueDate == Date.now
    }
    private lazy var scheduledTodos = totalTodos.where {
            return $0.dueDate > currentDate
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
        
        baseView.titleLabel.text = DateHelper.shared.string(from: currentDate)
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarbutton
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
    
    func reloadData() {
        baseView.titleLabel.text = DateHelper.shared.string(from: currentDate)
        
        todayTodos = totalTodos.where {
            let start = Calendar.current.startOfDay(for: currentDate)
            if let end = Calendar.current.date(byAdding: .day, value: 1, to: start) {
                return $0.dueDate >= start && $0.dueDate < end
            }
            return $0.dueDate == Date.now
        }
        
        scheduledTodos = totalTodos.where {
            return $0.dueDate > currentDate
        }
        
        flagedTodos = totalTodos.where {
            $0.flaged == true
        }
        
        completedTodos = totalTodos.where {
            $0.completed == true
        }
        
        baseView.collectionView.reloadData()
    }
    
    @objc
    func leftBarButtonTapped() {
        let calendarAlertViewController = CalendarAlertViewController(baseView: CalendarAlertView())
        calendarAlertViewController.modalPresentationStyle = .overFullScreen
        
        calendarAlertViewController.delegate = self
        
        NavigationManager.shared.presentVC(calendarAlertViewController, animated: true)
    }
    
    @objc func rightBarButtonTapped() {
        
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
        
        var count = 0
        switch type {
        case .today:
            count = todayTodos.count
        case .scheduled:
            count = scheduledTodos.count
        case .total:
            count = totalTodos.count
        case .flaged:
            count = flagedTodos.count
        case .completed:
            count = completedTodos.count
        }
        cell.configureData(type, count: count)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let category = categories[indexPath.row]
        
        var todos: Results<Todo>?
        
        switch category {
        case .total:
            todos = totalTodos
        case .today:
            todos = todayTodos
        case .scheduled:
            todos = scheduledTodos
        case .flaged:
            todos = flagedTodos
        case .completed:
            todos = completedTodos
        }
        
        if let todos = todos {
            let listViewController = ListViewController(
                baseView: ListView(),
                category: category,
                todos: todos
            )
            
            listViewController.delegate = self
            
            NavigationManager.shared.pushVC(listViewController)
        }
    }
}

extension MainViewController: RegisterViewControllerDelegate {
    func saveButtonTapped() {
        reloadData()
        baseView.collectionView.reloadData()
    }
}

extension MainViewController: ListViewControllerDelegate {
    func itemUpdated() {
        reloadData()
    }
}

extension MainViewController: CalendarAlertViewControllerDelegate {
    func conformButtonTapped(to date: Date) {
        currentDate = date
        reloadData()
    }
}

protocol ListViewControllerDelegate: AnyObject {
    func itemUpdated()
}
