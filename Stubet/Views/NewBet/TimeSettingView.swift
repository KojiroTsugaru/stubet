import SwiftUI

struct TimeSettingView: View {
    
    @ObservedObject var viewModel: SharedBetViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var showNewBet: Bool // Accept showNewBet as a Binding
    @Binding var showingClearModal: Bool

    var body: some View {
        VStack(spacing: 40) {
            Spacer() // Push content toward the center for better alignment
            
            VStack(alignment: .leading, spacing: 10) {
                Text("日付を選択")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack {
                    DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                        .labelsHidden()
                        .accentColor(.purple) // Change the accent color for the date picker
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 1))
            }
            .padding(.horizontal) // Horizontal padding for alignment
            
            VStack(alignment: .leading, spacing: 10) {
                Text("時間を選択")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack {
                    DatePicker("", selection: $viewModel.time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .accentColor(.purple) // Change the accent color for the time picker
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 1))
            }
            .padding(.horizontal)
            
            Spacer() // Pushes the content down, leaving space for the small button at the top-right corner
        }
        .padding()
        .navigationBarTitle("時間を設定", displayMode: .inline)
        .navigationBarItems(trailing: NavigationLink(destination: LocationSettingView(viewModel: viewModel, showNewBet: $showNewBet, showingClearModal: $showingClearModal)) {
            Text("次へ")
                .font(.headline)
                .foregroundColor(.orange)
        })
        .accentColor(.orange)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("エラー"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
