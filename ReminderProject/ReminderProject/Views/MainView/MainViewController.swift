//
//  MainViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

final class MainViewController: BaseViewController<MainView> {
    private let categories: [TodoCategory] = TodoCategory.allCases
    
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
    
    @objc func rightBarButtonTapped() {
        print(#function)
    }
    
    override func configureDelegate() {
        super.configureDelegate()
        
        baseView.collectionView.delegate = self
        baseView.collectionView.dataSource = self
        baseView.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        let type = categories[indexPath.row]
        cell.configureData(type)
        
        return cell
    }
}


