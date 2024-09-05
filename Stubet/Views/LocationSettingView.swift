//
//  LocationSetting.swift
//  Stubet
//
//  Created by 木嶋陸 on 2024/09/05.
//

import SwiftUI

struct LocationSettingView: View {
    @ObservedObject var viewModel: SharedBetViewModel
    
    var body: some View {
        VStack {
            Text("Location Setting")
            // Add location setting UI here
        }
        .navigationTitle("場所を設定")
    }
}

struct LocationSettingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SharedBetViewModel(currentUserId: "1")
        return NavigationView {
            LocationSettingView(viewModel: viewModel)
        }
    }
}
