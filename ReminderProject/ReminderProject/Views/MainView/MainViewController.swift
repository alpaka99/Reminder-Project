//
//  MainViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

final class MainViewController: BaseViewController {
    let categories: [TodoCategory] = TodoCategory.allCases
    override func configureDelegate() {
        super.configureDelegate()
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifier, for: indexPath) as? MainCollectionCell else { return UICollectionViewCell() }
        
        let type = categories[indexPath.row]
        cell.configureData(type)
        
        return cell
    }
}
