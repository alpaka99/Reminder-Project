//
//  MainViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

final class MainViewController: BaseViewController {
    
    override func configureDelegate() {
        super.configureDelegate()
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as UICollectionViewCell
        
        cell.backgroundColor = .systemGray.withAlphaComponent(0.5)
        return cell
    }
}
