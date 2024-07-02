//
//  TestBaseView.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

final class TestBaseView: BaseView {
    
    override func configureDelegate() {
        super.configureDelegate()
        
        print(#function, "This is from TestBaseView")
    }
}
