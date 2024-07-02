//
//  MainView.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class MainView: BaseView {
    let titleLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.flowLayout(spacing: 16, numberOfItemsInRow: 2, heightMultiplier: 0.5))
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
    }
    
    
    override func configureLayout() {
        super.configureLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
                .inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(20)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        titleLabel.text = "전체"
        titleLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        titleLabel.textColor = .gray
        
        collectionView.backgroundColor = .clear
    }
    
    override func configureDelegate(_ vc: BaseViewController?) {
        super.configureDelegate()
        
        collectionView.delegate = vc as? any UICollectionViewDelegate
        collectionView.dataSource = vc as? any UICollectionViewDataSource
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
}
