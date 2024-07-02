//
//  UICollectionViewCell+Extension.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

extension UICollectionView {
    static func flowLayout(spacing: CGFloat, numberOfItemsInRow: Int, heightMultiplier: CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        
        let items = CGFloat(numberOfItemsInRow)
        let width = (ScreenSize.width - ((spacing * 2) + (spacing * (items - 1)))) / items
        
        let height = width * heightMultiplier
        layout.itemSize = CGSize(
            width: width,
            height: height
        )
        
        return layout
    }
}
