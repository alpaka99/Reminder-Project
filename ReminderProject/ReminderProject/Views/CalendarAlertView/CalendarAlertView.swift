//
//  CalendarAlertView.swift
//  ReminderProject
//
//  Created by user on 7/5/24.
//

import UIKit

import SnapKit

final class CalendarAlertView: BaseView {
    let background = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let title = {
        let label = UILabel()
        label.text = "날짜 선택"
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    let calendarView =  {
        let calendar = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendar.calendar = gregorianCalendar
        
        return calendar
    }()
    
    let cancelButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.title = "취소"
        config.background.backgroundColor = .systemBlue
        config.baseForegroundColor = .white
        
        button.configuration = config
        
        return button
    }()
    
    let conformButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.title = "확인"
        config.background.backgroundColor = .systemBlue
        config.baseForegroundColor = .white
        
        button.configuration = config
        
        return button
    }()
    
    lazy var buttonStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 32
        stackView.alignment = .center
        
        return stackView
    }()
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.addSubview(background)
        background.addSubview(title)
        background.addSubview(calendarView)
        background.addSubview(buttonStackView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        background.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
            $0.size.equalTo(self.snp.size)
                .multipliedBy(0.75)
        }
        
        title.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(background)
                .inset(16)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom)
                .offset(16)
            $0.horizontalEdges.equalTo(background.snp.horizontalEdges)
                .inset(16)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom)
                .offset(16)
            $0.horizontalEdges.equalTo(background)
                .inset(16)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(conformButton)
    }
    
    override func draw(_ rect: CGRect) {
        background.sizeToFit()
        self.sizeToFit()
    }
}

