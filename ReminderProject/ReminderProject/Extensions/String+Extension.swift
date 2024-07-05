//
//  String+Extension.swift
//  ReminderProject
//
//  Created by user on 7/4/24.
//

extension String {
    func removeOnePrefix(_ prefix: String) -> Self {
        if self.hasPrefix(prefix) {
            let secondIndex = self.index(
                self.startIndex,
                offsetBy: 1
            )
            let result = String(self[secondIndex...])
            return result
        }
        return self
    }
    
    static var emptyString: String {
        return ""
    }
}

