//
//  RegisterView.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class RegisterView: BaseView {
    let memoView = RegisterOpenedCell()
    
    private(set) var dueDateTextField = {
        let disclosureCell = RegisterDisclosureCell()
        
        disclosureCell.configureData("마감일")
        
        return disclosureCell
    }()
    
    private(set) var tagTextField = {
        let disclosureCell = RegisterDisclosureCell()
        
        disclosureCell.configureData("태그")
        
        return disclosureCell
    }()
    
    private(set) var priorityTextField = {
        let disclosureCell = RegisterDisclosureCell()
        
        disclosureCell.configureData("우선 순위")
        
        return disclosureCell
    }()
    
    private(set) var imageTextField = {
        let disclosureCell = RegisterDisclosureCell()
        
        disclosureCell.configureData("이미지 추가")
        
        return disclosureCell
    }()
    
    lazy var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureArrandedSubViews()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(stackView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        stackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
                .inset(16)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
    }
    
    func configureArrandedSubViews() {
        stackView.addArrangedSubview(memoView)
        
        stackView.addArrangedSubview(dueDateTextField)
        stackView.addArrangedSubview(tagTextField)
        stackView.addArrangedSubview(priorityTextField)
        stackView.addArrangedSubview(imageTextField)
    }
}
