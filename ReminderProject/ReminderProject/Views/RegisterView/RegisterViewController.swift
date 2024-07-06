//
//  RegisterViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import PhotosUI
import UIKit

final class RegisterViewController: BaseViewController<RegisterView> {
    private let registerFieldTypes: [RegisterFieldType] = RegisterFieldType.allCases
    
    weak var delegate: RegisterViewControllerDelegate?
    
    private lazy var leftBarButton = {
        let barButton = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        return barButton
    }()
    
    private lazy var rightBarButton = {
        let barButton = UIBarButtonItem(
            title: "추가",
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        barButton.isEnabled = false
        return barButton
    }()
    
    override func configureUI() {
        super.configureUI()
        
        navigationItem.title = "새로운 할 일"
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func configureDelegate() {
        super.configureDelegate()
        
        baseView.memoView.textField.addTarget(
            self,
            action: #selector(textFieldTextChanged),
            for: .editingChanged
        )
        
        baseView.memoView.textView.delegate = self
        
        baseView.dueDateTextField.trailingButton.addTarget(
            self,
            action: #selector(dueDateTextFieldTrailingButtonTapped),
            for: .touchUpInside
        )
        
        baseView.tagTextField.trailingButton.addTarget(
            self,
            action: #selector(tagTextFieldTrailingButtonTapped),
            for: .touchUpInside
        )
        
        baseView.priorityTextField.trailingButton.addTarget(
            self,
            action: #selector(priorityTextFieldTrailingButtonTapped),
            for: .touchUpInside
        )
        
        baseView.imageTextField.trailingButton.addTarget(
            self,
            action: #selector(imageTextFieldTrailingButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    func textFieldTextChanged(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            rightBarButton.isEnabled = true
        } else {
            rightBarButton.isEnabled = false
        }
    }
    
    @objc
    func dueDateTextFieldTrailingButtonTapped(_ sender: UIButton) {
        let vc = DetailInputViewController(baseView: DetailInputView())
        
        vc.configureData(.dueDate)
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
        // MARK: present된 vc에서는 navigationManager를 이용한 push가 안됨
//        NavigationManager.shared.pushVC(vc, animated: true)
    }
    
    @objc
    func tagTextFieldTrailingButtonTapped(_ sender: UIButton) {
        let vc = DetailInputViewController(baseView: DetailInputView())
        
        vc.configureData(.tag)
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func priorityTextFieldTrailingButtonTapped(_ sender: UIButton) {
        let vc = DetailInputViewController(baseView: DetailInputView())
        
        vc.configureData(.priority)
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func imageTextFieldTrailingButtonTapped(_ sender: UIButton) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 30
        config.mode = .default
        
        let photoPicker = PHPickerViewController(configuration: config)
        
        photoPicker.delegate = self
        
        navigationController?.pushViewController(photoPicker, animated: true)
    }
    
    @objc
    func cancelButtonTapped() {
        NavigationManager.shared.dismiss(animated: true)
    }
    
    // MARK: Fetch TextField from baseView
    @objc
    func addButtonTapped() {
        guard let  title = baseView.memoView.textField.text else {
            return
        }
        
        let content = baseView.memoView.textView.text
        
        let unFormattedDueDate = baseView.dueDateTextField.content.text ?? ""
        let dueDate = DateHelper.shared.date(from: unFormattedDueDate)
        
        let tag = baseView.tagTextField.content.text
        
        let unConvertedPriority = baseView.priorityTextField.content.text ?? ""
        let priority = TodoPriority.stringInit(rawString: unConvertedPriority)?.rawValue
        
        let newTodo = Todo(
            title: title,
            content: content,
            dueDate: dueDate,
            tag: tag,
            priority: priority
        )
        
        RealmManager.shared.create(newTodo)
        
        if let image = baseView.imageTextField.thumbnailImage.image {
            // save image method
            saveImageToDocument(image: image, fileName: newTodo._id.stringValue)
        }
        
        delegate?.saveButtonTapped()
        
        NavigationManager.shared.dismiss(animated: true)
    }
}

extension RegisterViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}

extension RegisterViewController: DetailInputViewControllerDelegate {
    func sendDetailData(_ type: RegisterFieldType, text: String) {
        switch type {
        case .dueDate:
            baseView.dueDateTextField.content.text = text
        case .tag:
            baseView.tagTextField.content.text = text
        case .priority:
            baseView.priorityTextField.content.text = text
        default:
            break
        }
    }
}

extension RegisterViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) {[weak self] image, error in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self?.baseView.imageTextField.thumbnailImage.image = image
                    }
                }
            }
        }
        
        
        navigationController?.popViewController(animated: true)
    }
}

protocol RegisterViewControllerDelegate: AnyObject {
    func saveButtonTapped()
}
