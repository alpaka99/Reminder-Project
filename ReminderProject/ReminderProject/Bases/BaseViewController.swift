//
//  BaseViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

class BaseViewController<T: BaseView>: UIViewController {
    internal let baseView: T
    
    override func loadView() {
        self.view = baseView
    }
    
    init(baseView: T) {
        self.baseView = baseView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureDelegate()
    }
    
    internal func configureHierarchy() {
        
    }
    
    internal func configureLayout() {
        
    }
    
    internal func configureUI() {
        
    }
    
    internal func configureDelegate() {
        baseView.delegate = self
    }
}

extension BaseViewController: BaseViewDelegate { }
