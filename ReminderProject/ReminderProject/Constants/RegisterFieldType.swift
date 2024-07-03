//
//  RegisterFieldType.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//

enum RegisterFieldType: CaseIterable {
//    case memo(RegisterFieldMode)
    case dueDate
    case tag
    case priority
    case image
    
    var title: String {
        switch self {
//        case .memo(_):
//            return "제목"
        case .dueDate:
            return "마감일"
        case .tag:
            return "태그"
        case .priority:
            return "우선순위"
        case .image:
            return "이미지 추가"
        }
    }
    
}
