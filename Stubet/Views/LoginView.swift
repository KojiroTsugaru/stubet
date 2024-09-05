//
//  LoginView.swift
//  Stubet
//
//  Created by HAGIHARA KADOSHIMA on 2024/09/04.
//
import Foundation
import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel // ViewModelを注入

    var body: some View {
        VStack {
            Spacer() // 下部要素を押し下げるために追加

            // ロゴとテキストをVStackでまとめ、上部に配置
            VStack {
                // ロゴ部分（必要に応じて画像を追加）
                Image("ハッカソンロゴ02") // プレースホルダーとしてシステムアイコンを使用
                    .resizable() // 画像サイズを調整可能にする
                    .scaledToFit() // アスペクト比を維持してビューにフィットさせる
                    .frame(width: 210, height: 210) // サイズを30x30に設定
                Text("Stu BET")
                    .font(.title) // フォントサイズを小さく調整
                    .bold()
            }
            .padding()

            Spacer() // 中央にスペースを作るために追加

            // エラーメッセージ表示（viewModelから取得）
            if viewModel.showError {
                Text("Incorrect username or password")
                    .foregroundColor(.red)
                    .padding(.bottom)
            }

            // ユーザー名入力フィールド
            TextField("user name", text: $viewModel.username) // viewModelとバインディング
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
                .padding(.horizontal)

            // パスワード入力フィールド
            SecureField("Password", text: $viewModel.password) // viewModelとバインディング
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
                .padding(.horizontal)

            // ログインボタン
            Button(action: {
                viewModel.login() // ログイン処理をviewModelに委譲
            }) {
                Text("LOGIN")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(8)
            }
            .padding()

            Spacer() // 下部にスペースを作るために追加
        }
        .padding()
    }
}
