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
    @Published var userData: [String: Any]? = nil

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
            } else {
                // ログイン成功時の処理
                if let user = authResult?.user {
                    print("ログイン成功: \(user)")

                    // ユーザーIDの取得
                    let userID = user.uid

                    // Firestoreからユーザー情報を取得
                    let db = Firestore.firestore()
                    db.collection("users").document(userID).getDocument { (document, error) in
                        if let document = document, document.exists {
                            // ユーザーデータの取得成功
                            self.userData = document.data()
                            print("Firestoreからの取得成功: \(self.userData ?? [:])") 

                        } else {
                            print("Firestoreからの取得エラー: \(error?.localizedDescription ?? "不明なエラー")")
                        }
                    }
                }
            }
        }
        
    }
}
