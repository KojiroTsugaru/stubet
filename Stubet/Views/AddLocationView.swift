//
//  AddLocaionView.swift
//  Stubet
//
//  Created by KJ on 9/5/24.
//
import SwiftUI
import MapKit

struct AddLocationView: View {
    @StateObject private var viewModel = AddLocationViewModel()
    
    @State var locationName = ""
    
    var body: some View {
        VStack {
            MapSearchBar(text: $viewModel.searchText, onSearchButtonClicked: {
                viewModel.searchForLocation()
            })
            
            // Map View
            Map(coordinateRegion: $viewModel.region, interactionModes: .all, annotationItems: viewModel.selectedCoordinates) { coord in
                MapMarker(coordinate: coord.coordinate)
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
        .navigationTitle("場所を設定")
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView()
    }
}




#Preview {
    AddLocationView()
}
