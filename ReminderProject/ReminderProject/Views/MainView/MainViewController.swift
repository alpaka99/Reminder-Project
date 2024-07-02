//
//  MainViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

final class MainViewController: BaseViewController {
    let categories: [TodoCategory] = TodoCategory.allCases
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
