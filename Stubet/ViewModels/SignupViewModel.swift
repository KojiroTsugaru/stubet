//
//  SignupViewModel.swift
//  Stubet
//
//  Created by HAGIHARA KADOSHIMA on 2024/09/05.
//

import SwiftUI
import Combine
import FirebaseAuth
import Foundation
import FirebaseFirestore

class SignupViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var showError = false
    @Published var errorMessage = ""
    
    // バリデーションエラーメッセージ用のプロパティ
    @Published var usernameError: String = ""
    @Published var emailError: String = ""
    @Published var passwordError: String = ""
    @Published var confirmPasswordError: String = ""
    
    var onSignupSuccess: (() -> Void)?

    private var cancellables = Set<AnyCancellable>()

    init() {
        // 必要に応じて、初期値を設定
    }
    
    // バリデーションロジックを含むメソッド
    func validateFields() {
        // テキストボックスが空かどうか
        usernameError = username.isEmpty ? "Username is required." : ""
        emailError = email.isEmpty ? "Email is required." : ""
        passwordError = password.isEmpty ? "Password is required." : ""
        confirmPasswordError = confirmPassword.isEmpty ? "Confirmation is required." : ""

        // username条件
        
        // email条件
        
        // password条件
        passwordError = (password.count < 8) ? "Password length error" : ""
        
        // confirmPassword条件
        if password != confirmPassword{
            confirmPasswordError = "Password not match"
        }
        
        
    }
        
    func signup() {
        validateFields()

        // エラーがなければ続行
        if usernameError.isEmpty && emailError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty {
            // Firebaseにユーザー登録
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.showError = true
                    // エラーの詳細を表示するように変更
                    self.errorMessage = "Failed to sign up: \(error.localizedDescription)"
                    // エラーの詳細をコンソールに出力
                    print("Error during signup: \(error)")
                } else {
                    // ユーザー登録成功時の処理
                    self.showError = false
                    self.errorMessage = ""

                    // リフレッシュトークンの保存
                    if let refreshToken = authResult?.user.refreshToken {
                        UserDefaults.standard.set(refreshToken, forKey: "userRefreshToken")
                    }

                    // Firestoreにユーザー情報を保存
                    if let user = authResult?.user {
                        let db = Firestore.firestore()
                        let userData: [String: Any] = [
                            "userName": self.username, // ユーザー名を追加
                            "email": user.email ?? "",
                            "uid": user.uid,
                            "iconUrl" : "",
                            "displayName" : "",
                            "createdAt" : Timestamp(date: Date()),
                            "updatedAt" : Timestamp(date: Date()),
                            "friends" : [],
                            // 必要に応じて他のフィールドを追加
                        ]
                        db.collection("users").document(user.uid).setData(userData) { error in
                            if let error = error {
                                print("Error saving user data to Firestore: \(error)")
                            } else {
                                print("User data saved to Firestore successfully")
                            }
                        }
                    }

                    print("User signed up successfully: \(authResult?.user.email ?? "")")

                    
                    // ログイン処理を完了させる（必要に応じて実装を調整）
                    // 例: ログイン状態を管理するフラグを更新する、ユーザー情報を保存するなど

                    // ホーム画面に遷移
                    DispatchQueue.main.async {
                        self.onSignupSuccess?()
                    }
                    
                }
            }
        } else {
            showError = true
            errorMessage = "Please fix the errors above."
        }
    }
}
