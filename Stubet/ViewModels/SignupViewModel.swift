//
//  SignupViewModel.swift
//  Stubet
//
//  Created by HAGIHARA KADOSHIMA on 2024/09/05.
//

import SwiftUI
import Combine

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

    private var cancellables = Set<AnyCancellable>()

    init() {
        // 必要に応じて、初期値を設定
    }
    
    // バリデーションロジックを含むメソッド
    func validateFields() {
        // 例として、各フィールドが空かどうかの簡単なバリデーション
        usernameError = username.isEmpty ? "Username is required." : ""
        emailError = email.isEmpty ? "Email is required." : ""
        passwordError = password.isEmpty ? "Password is required." : ""
        confirmPasswordError = confirmPassword.isEmpty ? "Confirmation is required." : ""

        // その他のバリデーションもここに追加
    }

    func signup() {
        validateFields()

        // エラーがなければ続行、エラーがあればshowErrorをtrueに設定
        if usernameError.isEmpty && emailError.isEmpty && passwordError.isEmpty && confirmPasswordError.isEmpty {
            // サインアップ処理
        } else {
            showError = true
            errorMessage = "Please fix the errors above."
        }
    }
}
