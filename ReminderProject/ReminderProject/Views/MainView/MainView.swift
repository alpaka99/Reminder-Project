//
//  MainView.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import UIKit

import SnapKit

final class MainView: BaseView {
    private(set) var titleLabel = {
        let label = UILabel()
        label.text = "전체"
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    private(set) var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionView.flowLayout(
                spacing: 16,
                numberOfItemsInRow: 2,
                heightMultiplier: 0.5
            ))
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private(set) var newTodoButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "plus.circle.fill")
        config.title = "새로운 할 일"
        config.imagePlacement = .leading
        config.imagePadding = 8
        button.configuration = config
        
        return button
    }()
    
    private(set) var addListButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "목록 추가"
        
        button.configuration = config
        return button
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        self.addSubview(newTodoButton)
        self.addSubview(addListButton)
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
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        newTodoButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
                .offset(-16)
        }
        
        addListButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
                .offset(-16)
        }
    }
}
