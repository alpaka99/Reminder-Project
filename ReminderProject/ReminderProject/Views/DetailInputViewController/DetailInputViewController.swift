//
//  DetailInputViewController.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//

import UIKit

final class DetailInputViewController: BaseViewController<DetailInputView> {
    private var type: RegisterFieldType? = .dueDate
    
    weak var delegate: DetailInputDelegate?
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonTapped))
    }
    
    internal func configureData(_ type: RegisterFieldType) {
        self.type = type
    }
    
    @objc
    func completeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}


protocol DetailInputDelegate: AnyObject {
    func sendDetailData(_ type: RegisterFieldType, text: String)
}
