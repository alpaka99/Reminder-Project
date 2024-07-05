//
//  CalendarAlertViewController.swift
//  ReminderProject
//
//  Created by user on 7/5/24.
//

import UIKit

final class CalendarAlertViewController: BaseViewController<CalendarAlertView> {
    
    weak var delegate: CalendarAlertViewControllerDelegate?
    
    override func configureUI() {
        super.configureUI()
        
        view.backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    override func configureDelegate() {
        super.configureDelegate()
        
        baseView.calendarView.delegate = self
        let selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        baseView.calendarView.selectionBehavior = selectionBehavior
        
        baseView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        baseView.conformButton.addTarget(self, action: #selector(conformButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func conformButtonTapped() {
        dismiss(animated: true)
    }
}


extension CalendarAlertViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(dateComponents)
    }
    
    func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
        print(#function)
    }
}

protocol CalendarAlertViewControllerDelegate: AnyObject {
    func conformButtonTapped()
}
