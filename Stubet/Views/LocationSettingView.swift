//
//  AddLocaionView.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//
import SwiftUI
import MapKit

struct LocationSettingView: View {
    @StateObject var viewModel: SharedBetViewModel
    
    @State private var locationName = ""
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            
            MapSearchBar(text: $searchText, onSearchButtonClicked: {
                viewModel.searchForLocation(searchText: searchText)
            })
            
            // Map View
            Map(coordinateRegion: $viewModel.region, interactionModes: .all, annotationItems: viewModel.selectedCoordinates) { coord in
                MapPin(coordinate: coord.coordinate)
            }
            .cornerRadius(16)
            .onTapGesture {
                let coordinate = viewModel.region.center
                viewModel.selectLocation(coordinate: coordinate)
            }
            
            // Location Name Field
            VStack(alignment: .leading, spacing: 8) {
                Text("場所の名前")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 16)
                
                TextField("例: 千葉大学１号館", text: $locationName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal, 16)
            }
            .padding(.vertical, 16)
        }
        .navigationBarTitle("場所を設定", displayMode: .inline)
        //        .navigationBarItems(trailing: NavigationLink(destination: ConfirmNewBetView(viewModel: viewModel)) {
        //            Text("次へ")
        //        }
        .navigationBarItems(trailing: NavigationLink(destination: ConfirmNewBetView(viewModel: viewModel)) {
            Button(action: {
                viewModel.locationName = self.locationName
            }, label: {
                Text("次へ")
            })
        }
        )
    }
}

//struct AddLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationSettingView()
//    }
//}




//#Preview {
//    LocationSettingView()
//}
