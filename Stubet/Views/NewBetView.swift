//
//  CreateBetView.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/04.
//

import SwiftUI

struct NewBetView: View {
    @ObservedObject var viewModel: SharedBetViewModel = SharedBetViewModel(currentUserId: "1")
    
    @Environment(\.presentationMode) var presentationMode

    
    init() {
        self.viewModel = SharedBetViewModel(currentUserId: "1")
    }
    
    var body: some View {
        Form {
            Section(header: Text("誰にベットする？")) {
                Picker("名前", selection: $viewModel.selectedFriend) {
                    Text("選択してください").tag(nil as Friend?)
                    ForEach(viewModel.friends) { friend in
                        Text(friend.displayName).tag(friend as Friend?)
                    }
                }
            }
            
            Section(header: Text("タイトル")) {
                TextField("タイトル", text: $viewModel.title)
            }
            
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
            trailing: NavigationLink(destination: TimeSettingView(viewModel: viewModel)) {
                Text("次へ")
            }
            .disabled(!isFormValid)
        )
    }
    
    private var isFormValid: Bool {
        viewModel.selectedFriend != nil && !viewModel.title.isEmpty && !viewModel.description.isEmpty
    }
}

struct NewBetView_Previews: PreviewProvider {
    static var previews: some View {
        _ = SharedBetViewModel(currentUserId: "1")
        return NavigationView {
            NewBetView()
        }
    }
}
