//
//  CreateBetView.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/03.
//

import SwiftUI

struct CreateBetView: View {
    @StateObject private var viewModel = CreateBetViewModel()
    @State private var showingTimePicker = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("誰にベットする？")) {
                    Picker("選択", selection: $viewModel.selectedUser) {
                        if let friends = viewModel.currentUser?.friends {
                            ForEach(friends) { friend in
                                Text("User \(friend.user_id)").tag(friend as Follow?)
                            }
                        } else {
                            Text("No friends available").tag(nil as Follow?)
                        }
                    }
                }
                
                Section(header: Text("タイトル")) {
                    TextField("タイトル", text: $viewModel.title)
                }
                
                Section(header: Text("ベット内容")) {
                    TextEditor(text: $viewModel.betContent)
                        .frame(height: 200)
                        .overlay(
                            Group {
                                if viewModel.betContent.isEmpty {
                                    Text("ベット内容(200文字まで)")
                                        .foregroundColor(Color(.placeholderText))
                                        .padding(.leading, 4)
                                        .padding(.top, 8)
                                }
                            },
                            alignment: .topLeading
                        )
                }
                
                Button(action: {
                    showingTimePicker = true
                }) {
                    Text("時間を設定する")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("ベットを作成")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button("←") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .sheet(isPresented: $showingTimePicker) {
            Text("時間選択画面")
        }
    }
}

struct CreateBetView_Previews: PreviewProvider {
    static var previews: some View {
        CreateBetView()
    }
}
