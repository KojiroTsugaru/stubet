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
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $viewModel.region, interactionModes: .all, annotationItems: viewModel.selectedCoordinates) { coord in
                MapPin(coordinate: coord.coordinate)
            }
            .frame(height: 300)
            .onTapGesture {
                let coordinate = viewModel.region.center
                viewModel.selectLocation(coordinate: coordinate)
            }
            
            MapSearchBar(text: $viewModel.searchText, onSearchButtonClicked: {
                viewModel.searchForLocation()
            })
            
            if let coord = viewModel.selectedCoordinates.first?.coordinate {
                VStack(alignment: .leading) {
                    Text("Selected Location:")
                    Text("Latitude: \(coord.latitude)")
                    Text("Longitude: \(coord.longitude)")
                }
                .padding()
            }
            
            Spacer()
        }
        .navigationTitle("場所を設定")
    }
}



#Preview {
    AddLocationView()
}
