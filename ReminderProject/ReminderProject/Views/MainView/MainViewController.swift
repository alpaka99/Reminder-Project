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
    private var totalTodos = Array(RealmManager.shared.readAll(Todo.self))
    private var userCategories: Results<Category> = RealmManager.shared.readAll(Category.self)
    // https://stackoverflow.com/questions/35964884/how-do-i-filter-events-created-for-the-current-date-in-the-realm-swift/35965216#35965216
    private lazy var todayTodos = Array(totalTodos).filter {
        if let dueDate = $0.dueDate {
            return Calendar.current.isDate(dueDate, inSameDayAs: currentDate)
        }
        return false
    }
    private lazy var scheduledTodos = Array(totalTodos).filter {
        if let dueDate = $0.dueDate {
            return dueDate > currentDate
        }
        return false
    }
    
    private lazy var flagedTodos = Array(totalTodos).filter {
        $0.flaged == true
    }
    private lazy var completedTodos = Array(totalTodos).filter {
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
        
        baseView.addListButton.addTarget(self, action: #selector(addListButtonTapped), for: .touchUpInside)
    }
    
    func reloadData() {
        baseView.titleLabel.text = DateHelper.shared.string(from: currentDate)
        
        totalTodos = Array(RealmManager.shared.readAll(Todo.self))
        
        todayTodos = Array(totalTodos).filter {
            if let dueDate = $0.dueDate {
                return Calendar.current.isDate(dueDate, inSameDayAs: currentDate)
            }
            return false
        }
        
        scheduledTodos = Array(totalTodos).filter {
            if let dueDate = $0.dueDate {
                return dueDate > currentDate
            }
            return false
        }
        
        flagedTodos = Array(totalTodos).filter {
            $0.flaged == true
        }
        completedTodos = Array(totalTodos).filter {
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
    
    @objc 
    func rightBarButtonTapped() {
        
    }
    
    
    @objc
    func newTodoButtonTapped() {
        let registerViewController = RegisterViewController(baseView: RegisterView())
        
        registerViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: registerViewController)
        NavigationManager.shared.presentVC(navigationController)
    }
    
    @objc
    func addListButtonTapped(_ sender: UIButton) {
        let ac = UIAlertController(
            title: "새로운 카테고리",
            message: "여러분만의 카테고리를 만들어주세요",
            preferredStyle: .alert
        )
        ac.addTextField { [weak self] textField in
            textField.placeholder = "카테고리 이름을 입력해주세요"
            textField.addTarget(
                self,
                action: #selector(self?.textFieldSubmitted),
                for: .editingDidEndOnExit
            )
        }
        
        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel
        ) { _ in
            print("cancel")
        }
        ac.addAction(cancelAction)
        
        let conformAction = UIAlertAction(
            title: "확인",
            style: .default
        ) { [weak self] _ in
            if let textField = ac.textFields?.first {
                self?.textFieldSubmitted(textField)
            }
            print("conform")
        }
        ac.addAction(conformAction)
        
        
        present(ac, animated: true)
    }
    
    @objc
    func textFieldSubmitted(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            let newCategory = Category(
                categoryName: text,
                iconName: "folder.fill",
                backgroundColor: UIColor.systemOrange.toHexString()
            )
            
            RealmManager.shared.create(newCategory)
            
            baseView.collectionView.reloadSections(IndexSet(integer: 1))
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return categories.count
        } else if section == 1 {
            return userCategories.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
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
        } else if indexPath.section == 1 {
            let type = userCategories[indexPath.row]
            
            cell.title.text = type.categoryName
            cell.icon.image = UIImage(systemName: type.iconName)
            cell.iconBackground.backgroundColor = UIColor.hexToColor(type.backgroundColor)
            
            let count = type.todos.count
            cell.number.text = String(count)
            
            return cell
        } else {
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if indexPath.section == 0 {
            
            let category = categories[indexPath.row]
            
            var todos: Array<Todo> = []
            
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
            
            
                let listViewController = ListViewController(
                    baseView: ListView(),
                    categoryTitle: category.title,
                    todos: todos
                )
                
                listViewController.delegate = self
                
                NavigationManager.shared.pushVC(listViewController)
            
        } else if indexPath.section == 1 {
            let category = userCategories[indexPath.row]
            let todos = Array(category.todos)
            
            let listViewController = ListViewController(
                baseView: ListView(),
                categoryTitle: category.categoryName,
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
