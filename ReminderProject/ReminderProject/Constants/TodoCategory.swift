//
//  MainViewCellType.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//
import UIKit

enum TodoCategory: CaseIterable {
    case today
    case scheduled
    case total
    case flaged
    case completed
    
    var backgroundColor: UIColor {
        switch self {
        case .today:
            return .systemBlue
        case .scheduled:
            return .systemRed
        case .total:
            return .systemBrown
        case .flaged:
            return .systemOrange
        case .completed:
            return .darkGray
        }
    }
    
    var systemName: String {
        switch self {
        case .today:
            return "star" // MARK: Switch to appropriate sf symbol
        case .scheduled:
            return "calendar"
        case .total:
            return "tray.fill"
        case .flaged:
            return "flag.fill"
        case .completed:
            return "checkmark"
        }
    }
    
    var title: String {
        switch self {
        case .today:
            return "오늘"
        case .scheduled:
            return "예정"
        case .total:
            return "전체"
        case .flaged:
            return "깃발 표시"
        case .completed:
            return "완료됨"
        }
    }
}
