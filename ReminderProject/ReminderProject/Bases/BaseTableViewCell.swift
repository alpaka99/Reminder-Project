//
//  BaseTableViewCell.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
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
}
