//
//  BaseView.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

class BaseView: UIView {
    weak var delegate: BaseViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
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
        self.backgroundColor = .white
    }
    
    internal func configureDelegate(_ vc: BaseViewController? = nil) {
        self.delegate = vc
    }
}


protocol BaseViewDelegate: BaseViewController {
    func configureDelegate()
}
