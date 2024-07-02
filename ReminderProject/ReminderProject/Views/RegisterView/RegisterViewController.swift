//
//  RegisterViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

final class RegisterViewController: BaseViewController {
    let registerFieldTypes: [RegisterFieldType] = RegisterFieldType.allCases
}

extension RegisterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegisterOpenedCell.identifier, for: indexPath) as? RegisterOpenedCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(#function, indexPath)
    }
}
