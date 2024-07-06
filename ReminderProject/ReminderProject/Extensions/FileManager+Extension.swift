//
//  FileManager+Extension.swift
//  ReminderProject
//
//  Created by user on 7/6/24.
//

import UIKit

extension UIViewController {
    func saveImageToDocument(image: UIImage, fileName: String) {
        // 1. document directory 찾아가기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("DocumentDirectory Finding error")
            return
        }
        
        // 2. 이미지 저장할 경로 지정
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpeg")
        
        // 3. 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.75) else {
            print("Image Compression Error")
            return
        }
        
        // 이미지 저장
        do {
            try data.write(to: fileURL)
        } catch {
            print("File Save Failure")
            print(error.localizedDescription)
        }
    }
    
    func deleteImageFromDocument(fileName: String) {
        // 1. documentPath(base URL) 찾기
        guard let path = FileManager.default.urls(
            for: .applicationDirectory,
            in: .userDomainMask
        ).first else {
            print("DocumentPath Finding Error")
            return
        }
        
        // 2. 정확한 url 만들기
        let fileURL = path.appendingPathComponent("\(fileName).jpeg")
        
        // 3. 해당 url에 파일이 있는지 확인하고
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                print("File Deletion Error")
                print(error)
            }
        }
    }
}
