//
//  LoginViewModel.swift
//  Stubet
//
//  Created by HAGIHARA KADOSHIMA on 2024/09/04.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var showError = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        // 必要に応じて、usernameやpasswordの初期値を設定
    }

    func login() {
        // ログインボタンがタップされたときの処理
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
            guard let self = self else { return } // weak self のアンラップ

            if let error = error {
                // エラー処理 (例：アラート表示)
                print("ログインエラー: \(error.localizedDescription)")
                // ... エラーに応じた処理 ...
            } else {
                // ログイン成功時の処理
                if let user = authResult?.user {
                    print("ログイン成功: \(user)")
                    // ... ログイン後の画面遷移など ...
                }
            }
        }
        

        // 例:
        if username == "userName" && password == "correct_password" {
            // ログイン成功時の処理
            showError = false
        } else {
            // ログイン失敗時の処理
            showError = true
        }
    }
}
