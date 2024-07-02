//
//  RegisterView.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class RegisterView: BaseView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.flowLayout(spacing: 12, numberOfItemsInRow: 1, heightMultiplier: 0.13))
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(collectionView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
                .inset(8)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        self.backgroundColor = .black
        
        collectionView.backgroundColor = .clear
    }
    
    override func configureDelegate(_ vc: BaseViewController? = nil) {
        super.configureDelegate()
        
        self.delegate = vc
        
        collectionView.delegate = delegate as? UICollectionViewDelegate
        collectionView.dataSource = delegate as? UICollectionViewDataSource
        collectionView.register(RegisterOpenedCell.self, forCellWithReuseIdentifier: RegisterOpenedCell.identifier)
        collectionView.register(RegisterDisclosureCell.self, forCellWithReuseIdentifier: RegisterDisclosureCell.identifier)
    }
}

enum RegisterFieldType: CaseIterable {
    static var allCases: [RegisterFieldType] = [
        memo(.opened),
        dDay(.disclosured),
        tag(.disclosured),
        priority(.disclosured),
        image(.disclosured)
    ]
    
    case memo(RegisterFieldMode)
    case dDay(RegisterFieldMode)
    case tag(RegisterFieldMode)
    case priority(RegisterFieldMode)
    case image(RegisterFieldMode)
    
}

enum RegisterFieldMode {
    case opened
    case disclosured
}
