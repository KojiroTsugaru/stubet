//
//  SaveImageViewModel.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import Foundation
import FirebaseStorage
import UIKit

class SaveImageViewModel: ObservableObject {
    @Published var isUploading = false
    @Published var uploadStatus = ""
    @Published var isUploadSuccess = false

    private let storage = Storage.storage()

    func saveImage() {
        guard let image = UIImage(named: "sample"),
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            uploadStatus = "Failed to prepare image"
            isUploadSuccess = false
            return
        }

        isUploading = true
        uploadStatus = ""

        let imageName = "sample_\(Date().timeIntervalSince1970).jpg"
        let storageRef = storage.reference().child("images/\(imageName)")

        storageRef.putData(imageData, metadata: nil) { [weak self] metadata, error in
            DispatchQueue.main.async {
                self?.isUploading = false

                if let error = error {
                    self?.uploadStatus = "Upload failed: \(error.localizedDescription)"
                    self?.isUploadSuccess = false
                } else {
                    self?.uploadStatus = "Image uploaded successfully"
                    self?.isUploadSuccess = true
                }
            }
        }
    }
}
