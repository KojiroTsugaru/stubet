////
////  TestCloudStrageView.swift
////  Stubet
////
////  Created by Pro on 2024/09/05.
////
//
//import SwiftUI
//import FirebaseStorage
//import PhotosUI
//
//struct TestCloudStrageView: View {
//    @State private var selectedImage: UIImage?
//    @State private var isImagePickerPresented = false
//    @State private var uploadStatus = ""
//
//    var body: some View {
//        VStack {
//            if let image = selectedImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 200)
//            }
//
//            Button("画像を選択") {
//                isImagePickerPresented = true
//            }
//
//            Button("アップロード") {
//                uploadImage()
//            }
//            .disabled(selectedImage == nil)
//
//            Text(uploadStatus)
//        }
//        .sheet(isPresented: $isImagePickerPresented) {
//            ImagePicker(image: $selectedImage)
//        }
//    }
//
//    func uploadImage() {
//        guard let image = selectedImage,
//              let imageData = image.jpegData(compressionQuality: 0.8) else {
//            uploadStatus = "画像の準備に失敗しました"
//            return
//        }
//
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//        let imageRef = storageRef.child("images/\(UUID().uuidString).jpg")
//
//        uploadStatus = "アップロード中..."
//
//        imageRef.putData(imageData, metadata: nil) { metadata, error in
//            if let error = error {
//                uploadStatus = "エラー: \(error.localizedDescription)"
//            } else {
//                uploadStatus = "アップロード成功"
//            }
//        }
//    }
//}
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Environment(\.presentationMode) private var presentationMode
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        let parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            parent.presentationMode.wrappedValue.dismiss()
//
//            guard let provider = results.first?.itemProvider else { return }
//
//            if provider.canLoadObject(ofClass: UIImage.self) {
//                provider.loadObject(ofClass: UIImage.self) { image, _ in
//                    self.parent.image = image as? UIImage
//                }
//            }
//        }
//    }
//}
