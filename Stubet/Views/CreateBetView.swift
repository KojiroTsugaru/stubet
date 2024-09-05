//
//  CreateBetView.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/04.
//

import SwiftUI

struct CreateBetView: View {
    @ObservedObject var viewModel: CreateBetViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            // 友人を選択するセクション
            Section(header: Text("誰にベットする？")) {
                Picker("名前", selection: $viewModel.selectedFriend) {
                    Text("選択してください").tag(nil as Friend?)
                    ForEach(viewModel.friends) { friend in
                        Text(friend.displayName).tag(friend as Friend?)
                    }
                }
            }
            
            // タイトル入力セクション
            Section(header: Text("タイトル")) {
                TextField("タイトル", text: $viewModel.title)
            }
            
            // ベット内容入力セクション
            Section(header: Text("ベット内容")) {
                TextEditor(text: $viewModel.description)
                    .frame(height: 100)
            }
        }
        .navigationTitle("ベットを作成")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("戻る")
                }
            },
            trailing: NavigationLink(destination: TimeSettingView()) {
                Text("次へ")
            }
            .disabled(!isFormValid)
        )
    }
    
    // フォームが有効かどうかの判定
    private var isFormValid: Bool {
        viewModel.selectedFriend != nil && !viewModel.title.isEmpty && !viewModel.description.isEmpty
    }
}

struct CreateBetView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleFriends = [
            Friend(id: "1", data: [
                "userName": "johndoe",
                "displayName": "John Doe",
                "icon_url": "https://example.com/john.jpg"
            ]),
            Friend(id: "2", data: [
                "userName": "janedoe",
                "displayName": "Jane Doe",
                "icon_url": "https://example.com/jane.jpg"
            ]),
            Friend(id: "3", data: [
                "userName": "bobsmith",
                "displayName": "Bob Smith",
                "icon_url": "https://example.com/bob.jpg"
            ])
        ]
        
        let viewModel = CreateBetViewModel(currentUserId: "1")
        viewModel.friends = sampleFriends
        viewModel.selectedFriend = sampleFriends.first
        viewModel.title = "サンプルベット"
        viewModel.description = "これはサンプルのベット内容です。友人と楽しく賭けましょう！"
        
        return NavigationView {
            CreateBetView(viewModel: viewModel)
        }
    }
}
