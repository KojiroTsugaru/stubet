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
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    @Published var userEmail = ""
    @Published var password = ""
    @Published var showError = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        // 必要に応じて、usernameやpasswordの初期値を設定
    }

    func login() {
        // ログインボタンがタップされたときの処理
        Auth.auth().signIn(withEmail: userEmail, password: password) { [weak self] authResult, error in
            guard let self = self else { return } // weak self のアンラップ

            if let error = error {
                // エラー処理 (例：アラート表示)
                print("ログインエラー: \(error.localizedDescription)")
                // ... エラーに応じた処理 ...
            } else {
                // ログイン成功時の処理
                if let user = authResult?.user {
                    print("ログイン成功: \(user)")

                    // ユーザーIDの取得
                    let userID = user.uid

                    // Firestoreなどにユーザー情報を保存する場合
                    let db = Firestore.firestore()
                    db.collection("users").document(userID).setData([
                        "email": user.email ?? "",
                        // その他のユーザー情報
                    ]) { err in
                        if let err = err {
                            print("Firestoreへの保存エラー: \(err)")
                        } else {
                            print("Firestoreへの保存成功")
                        }
                    }

                    // ログイン後の画面遷移
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
//                    self.navigationController?.pushViewController(mainViewController, animated: true)
                }
            }
        }
        

        // 例:
        if userEmail == "userName" && password == "correct_password" {
            // ログイン成功時の処理
            showError = false
        } else {
            // ログイン失敗時の処理
            showError = true
        }
    }
}
