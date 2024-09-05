//
//  SaveImageView.swift
//  Stubet
//
//  Created by Pro on 2024/09/05.
//

import SwiftUI
import FirebaseStorage

struct SaveImageView: View {
    @StateObject private var viewModel = SaveImageViewModel()
    
    var body: some View {
        VStack {
            if let image = UIImage(named: "sample") {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            
            Button("Save Image") {
                viewModel.saveImage()
            }
            .padding()
            .disabled(viewModel.isUploading)
            
            if viewModel.isUploading {
                ProgressView()
            }
            
            Text(viewModel.uploadStatus)
                .foregroundColor(viewModel.isUploadSuccess ? .green : .red)
        }
    }
}
