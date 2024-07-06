//
//  DetailInputViewController.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//

import UIKit

final class DetailInputViewController: BaseViewController<DetailInputView> {
    private var type: RegisterFieldType? = .dueDate
    
    weak var delegate: DetailInputViewControllerDelegate?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let type = type else { return }
        
        
        let detailData = baseView.sendDetailData()
        
        delegate?.sendDetailData(type, text: detailData)
    }
    
    override func configureUI() {
        super.configureUI()
        
        guard let type = type else { return }
        baseView.configureData(type)
        
    }
    
    internal func configureData(_ type: RegisterFieldType) {
        self.type = type
    }
}


protocol DetailInputViewControllerDelegate: AnyObject {
    func sendDetailData(_ type: RegisterFieldType, text: String)
}

