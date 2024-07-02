//
//  BaseViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

class BaseViewController: UIViewController {
    private var baseView: BaseView? // force unwrapping 바꾸는 방법 생각해보기
    
    override func loadView() {
        self.view = baseView
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(baseView: BaseView) {
        self.init(nibName: nil, bundle: nil)
        self.baseView = baseView
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
        baseView?.configureDelegate(self)
    }
}

extension BaseViewController: BaseViewDelegate {
    
}
