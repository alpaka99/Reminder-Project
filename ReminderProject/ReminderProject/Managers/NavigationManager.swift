////
////  NavigationManager.swift
////  ReminderProject
////
////  Created by user on 7/3/24.
////
//
import UIKit
//
final class NavigationManager {
    static let shared = NavigationManager()
    private(set) var navigationController = UINavigationController(rootViewController: MainViewController(baseView: MainView()))
    
    private init() { }
    
    internal func pushVC(_ vc: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(vc, animated: animated)
    }
    
    internal func presentVC(_ vc: UIViewController, animated: Bool = true) {
        navigationController.present(vc, animated: animated)
    }
    
    internal func popVC(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    internal func dismiss(animated: Bool) {
        navigationController.dismiss(animated: true)
    }
    
    // MARK: Replace VC -> self.navigationController를 새로 초기화해주고, window를 scenedelegate에서 끌고와서 다시 넣어주는 방식?
//    internal func replaceVC(_ vc: BaseViewController<BaseView>) {
//        let navigationController = UINavigationController(rootViewController: vc)
//        
//        self.window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//    }
}
