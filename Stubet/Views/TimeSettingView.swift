//
//  TimeSettingView.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/05.
//
import SwiftUI

struct TimeSettingView: View {
    @ObservedObject var viewModel: SharedBetViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    init(viewModel : SharedBetViewModel){
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("時間を設定")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Date")
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                        .labelsHidden()
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.purple, lineWidth: 1))
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Time")
                    .font(.caption)
                    .foregroundColor(.gray)
                HStack {
                    DatePicker("", selection: $viewModel.time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.purple, lineWidth: 1))
            }
            
            Spacer()
            
            NavigationLink(destination: LocationSettingView(viewModel: viewModel)) {
                Text("場所を設定する")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
//        .navigationBarTitle("時間を設定", displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("戻る")
            }
        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text("エラー"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct TimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SharedBetViewModel(currentUserId: "1")
        return NavigationView {
            TimeSettingView(viewModel: viewModel)
        }
    }
}
