import Foundation
import SwiftUI
struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @State private var isShowingSignupView = false // サインアップ画面表示フラグ
    
    init(){
        self.viewModel = LoginViewModel()
    }

    var body: some View {
        NavigationView { // NavigationViewを追加
            VStack {
                Spacer()

                // ロゴとテキストをVStackでまとめ、上部に配置
                VStack {
                    // ロゴ部分（必要に応じて画像を追加）
                    Image("ハッカソンロゴ02")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210, height: 210)
                    Text("Stu BET")
                        .font(.title)
                        .bold()
                }
                .padding()

                Spacer()

                // エラーメッセージ表示（viewModelから取得）
                if viewModel.showError {
                    Text("Incorrect username or password")
                        .foregroundColor(.red)
                        .padding(.bottom)
                }

                // ユーザー名入力フィールド
                TextField("user name", text: $viewModel.userEmail)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                    .padding(.horizontal)

                // パスワード入力フィールド
                SecureField("Password", text: $viewModel.password)
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
                    viewModel.login()
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

                // サインアップへの案内とボタン
                HStack {
                    Text("アカウントをお持ちでないですか？")
                    NavigationLink(destination: SignupView()) { // SignupViewへの遷移を設定
                        Button("新規登録") {
                            isShowingSignupView = true
                        }
                    }
                }
                .padding()

                Spacer()
            }
            .padding()
        } // NavigationViewの閉じ括弧
    }
}
