//
//  ConfirmNewBetView.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//

import SwiftUI

struct ConfirmNewBetView: View {
    @ObservedObject var viewModel: SharedBetViewModel
    var body: some View {
        Text(viewModel.title)
    }
}

//#Preview {
//    ConfirmNewBetView()
//}
