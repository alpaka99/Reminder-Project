//
//  DetailTodoViewController.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//

import UIKit

final class DetailTodoViewController: BaseViewController<DetailTodoView> {
    
    override func configureUI() {
        super.configureUI()
        
        navigationItem.title = "Todo 상세 데이터"
    }
}
