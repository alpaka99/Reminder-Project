//
//  BaseCollectionViewCell.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureDelegate()
    }
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configureHierarchy() {
        
    }
    
    internal func configureLayout() {
        
    }
    
    internal func configureUI() {
        
    }
    
    internal func configureDelegate() {
        
    }
}
