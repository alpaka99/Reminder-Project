//
//  RegisterViewModel.swift
//  ReminderProject
//
//  Created by user on 7/10/24.
//

import Foundation

final class RegisterViewModel {
    let registerFieldTypes: [RegisterFieldType] = RegisterFieldType.allCases
    
    var inputTitle = Observable("")
    var inputContent: Observable<String?> = Observable("")
    var inputDate = Observable("")
    var inputTag = Observable("")
    var inputPriority = Observable("")
    var inputImage: Observable<Data?> = Observable(Data())
    var inputDetailInputType = Observable(RegisterFieldType.dueDate)
    
    var inputCancelButtonTapped: Observable<Void?> = Observable(())
    var addButtonTapped: Observable<Void?> = Observable(())
}
