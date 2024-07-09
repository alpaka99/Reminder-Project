//
//  RegisterViewController.swift
//  ReminderProject
//
//  Created by user on 7/2/24.
//

import PhotosUI
import UIKit

final class RegisterViewController: BaseViewController<RegisterView> {
    
    let viewModel = RegisterViewModel()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
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
    
    func bindData() {
        viewModel.inputDate.bind { [weak self] value in
            self?.baseView.dueDateTextField.content.text = value
        }
        
        viewModel.inputTag.bind { [weak self] value in
            self?.baseView.tagTextField.content.text = value
        }
        
        viewModel.inputPriority.bind { [weak self] value in
            self?.baseView.priorityTextField.content.text = value
        }
        
        viewModel.inputImage.bind { [weak self] value in
            if let value = value, let image = UIImage(data: value) {
                self?.baseView.imageTextField.thumbnailImage.image = image
            }
            self?.navigationController?.popViewController(animated: true)
        }
        
        viewModel.addButtonTapped.bind {[weak self] _ in
            guard let title = self?.viewModel.inputTitle.value else { return }
            
            let inputDate = self?.viewModel.inputDate.value ?? ""
            let dueDate = DateHelper.shared.date(from: inputDate)
            
            let unConvertedPriority = self?.viewModel.inputPriority.value ?? ""
            let priority = TodoPriority.stringInit(rawString: unConvertedPriority)
            
            let newTodo = Todo(
                title: title,
                content: self?.viewModel.inputContent.value,
                dueDate: dueDate,
                tag: self?.viewModel.inputTag.value,
                priority: priority?.rawValue
            )
            
            RealmManager.shared.create(newTodo)
            
            if let data = self?.viewModel.inputImage.value, let image = UIImage(data: data) {
                self?.saveImageToDocument(image: image, fileName: newTodo._id.stringValue)
            }
            
            self?.delegate?.saveButtonTapped()
            
            NavigationManager.shared.dismiss(animated: true)
        }
        
        viewModel.inputTitle.bind { [weak self] value in
            print(value)
            self?.rightBarButton.isEnabled = !value.isEmpty
        }
        
        viewModel.inputDetailInputType.bind { [weak self] value in
            
            switch value {
            case .dueDate, .tag, .priority:
                let vc = DetailInputViewController(baseView: DetailInputView())
                
                vc.configureData(value)
                vc.delegate = self
                
                self?.navigationController?.pushViewController(vc, animated: true)
            case .image:
                var config = PHPickerConfiguration()
                config.selectionLimit = 30
                config.mode = .default
                
                let photoPicker = PHPickerViewController(configuration: config)
                
                photoPicker.delegate = self
                
                self?.navigationController?.pushViewController(photoPicker, animated: true)
            }
        }
        
        viewModel.inputCancelButtonTapped.bind { _ in
            NavigationManager.shared.dismiss(animated: true)
        }
    }
    
    @objc
    func textFieldTextChanged(_ sender: UITextField) {
        if let text = sender.text {
            viewModel.inputTitle.value = text
        }
    }
    
    @objc
    func dueDateTextFieldTrailingButtonTapped(_ sender: UIButton) {
        viewModel.inputDetailInputType.value = .dueDate
    }
    
    @objc
    func tagTextFieldTrailingButtonTapped(_ sender: UIButton) {
        viewModel.inputDetailInputType.value = .tag
    }
    
    @objc
    func priorityTextFieldTrailingButtonTapped(_ sender: UIButton) {
        viewModel.inputDetailInputType.value = .priority
    }
    
    @objc
    func imageTextFieldTrailingButtonTapped(_ sender: UIButton) {
        viewModel.inputDetailInputType.value = .image
    }
    
    @objc
    func cancelButtonTapped() {
        viewModel.inputCancelButtonTapped.value = ()
    }
    
    // MARK: Fetch TextField from baseView
    @objc
    func addButtonTapped() {
        viewModel.addButtonTapped.value = ()
    }
}

extension RegisterViewController: UITextViewDelegate {
    
}

extension RegisterViewController: DetailInputViewControllerDelegate {
    func sendDetailData(_ type: RegisterFieldType, text: String) {
        switch type {
        case .dueDate:
            viewModel.inputDate.value = text
        case .tag:
            viewModel.inputTag.value = text
        case .priority:
            viewModel.inputPriority.value = text
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
                        self?.viewModel.inputImage.value = image.jpegData(compressionQuality: 0.5)
                    }
                }
            }
        }
    }
}

protocol RegisterViewControllerDelegate: AnyObject {
    func saveButtonTapped()
}
