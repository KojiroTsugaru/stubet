//
//  SignupView.swift
//  Stubet
//
//  Created by HAGIHARA KADOSHIMA on 2024/09/05.
//
import Foundation
import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel: SignupViewModel // SignupViewModelを注入

    var body: some View {
        VStack {
            // ロゴとテキストをVStackでまとめ、上部に配置
            VStack(spacing: 10) {
                // ロゴ部分（サイズを小さく調整）
                Image("ハッカソンロゴ02")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150) // サイズを調整

                // 文字のサイズを少し小さくして上に配置
                Text("Stu BET")
                    .font(.title2) // 文字のサイズを調整
                    .bold()
            }
            .padding(.top, 20) // 上に少し余白を追加

            Spacer() // スペースを入れて全体を上に持ち上げる

            // エラーメッセージ表示（viewModelから取得）
            if viewModel.showError {
                Text(viewModel.errorMessage) // エラーメッセージをviewModelから取得
                    .foregroundColor(.red)
                    .padding(.bottom)
            }

            // ユーザー名入力フィールドとエラーメッセージ
            VStack(alignment: .leading, spacing: 5) {
                TextField("user name", text: $viewModel.username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding(.horizontal)
                
                if viewModel.usernameError != "" {
                    Text(viewModel.usernameError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading, 16)
                }
            }
            .padding(.bottom, 10) // 各フィールドの間に隙間を追加

            // メールアドレス入力フィールドとエラーメッセージ
            VStack(alignment: .leading, spacing: 5) {
                TextField("email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding(.horizontal)
                
                if viewModel.emailError != "" {
                    Text(viewModel.emailError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading, 16)
                }
            }
            .padding(.bottom, 10)

            // パスワード入力フィールドとエラーメッセージ
            VStack(alignment: .leading, spacing: 5) {
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding(.horizontal)
                
                if viewModel.passwordError != "" {
                    Text(viewModel.passwordError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading, 16)
                }
            }
            .padding(.bottom, 10)

            // パスワード確認入力フィールドとエラーメッセージ
            VStack(alignment: .leading, spacing: 5) {
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding(.horizontal)
                
                if viewModel.confirmPasswordError != "" {
                    Text(viewModel.confirmPasswordError)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.leading, 16)
                }
            }
            .padding(.bottom, 10)

            // 新規登録ボタン
            Button(action: {
                viewModel.signup() // 新規登録処理をviewModelに委譲
            }) {
                Text("SIGN UP")
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
