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
    private lazy var stackView = UIStackView()
    
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
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .black
        
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
    }
    
    func configureArrandedSubViews() {
        
        stackView.addArrangedSubview(memoView)
        
        RegisterFieldType.allCases.forEach { type in
            let registerDisclosureView = RegisterDisclosureCell()
            
            registerDisclosureView.configureData(type)
            stackView.addArrangedSubview(registerDisclosureView)
        }
    }
    
    override func configureDelegate(_ vc: BaseViewController? = nil) {
        super.configureDelegate()
        
        self.delegate = vc
        
        memoView.configureDelegate(vc)
    }
}

enum RegisterFieldType: CaseIterable {
    static var allCases: [RegisterFieldType] = [
//        memo(.opened),
        dDay(.disclosured),
        tag(.disclosured),
        priority(.disclosured),
        image(.disclosured)
    ]
    
//    case memo(RegisterFieldMode)
    case dDay(RegisterFieldMode)
    case tag(RegisterFieldMode)
    case priority(RegisterFieldMode)
    case image(RegisterFieldMode)
    
    var title: String {
        switch self {
//        case .memo(_):
//            return "제목"
        case .dDay(_):
            return "마감일"
        case .tag(_):
            return "태그"
        case .priority(_):
            return "우선순위"
        case .image(_):
            return "이미지 추가"
        }
    }
    
}

enum RegisterFieldMode {
    case opened
    case disclosured
}
