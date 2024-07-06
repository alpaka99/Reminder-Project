//
//  TodoPriority.swift
//  ReminderProject
//
//  Created by user on 7/6/24.
//

enum TodoPriority: Int, CaseIterable {
    case high = 0
    case medium
    case low
    
    static var allContents: [String] {
        let allCases = Self.allCases
        var allContents: [String] = []
        
        allCases.forEach { priority in
            allContents.append(priority.content)
        }
        
        return allContents
    }
    
    static func intInit(rawString: String) -> Self? {
        guard let rawValue = Int(rawString) else { return nil }
        
        return Self.init(rawValue: rawValue)
    }
    
    static func stringInit(rawString: String) -> Self? {
        switch rawString {
        case "High🔴":
            return .high
        case "Medium🟡":
            return .medium
        case "Low🟣":
            return .low
        default:
            return nil
        }
    }
    
    
    var content: String {
        switch self {
        case .high:
            return "High🔴"
        case .medium:
            return "Medium🟡"
        case .low:
            return "Low🟣"
        }
    }
}
