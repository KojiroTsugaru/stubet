import SwiftUI
import MapKit

struct LocationSettingView: View {
    @StateObject var viewModel: SharedBetViewModel
    @State private var locationName = ""
    @State private var searchText: String = ""
    @Binding var showNewBet: Bool // Accept showNewBet as a Binding
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Map Search Bar
            MapSearchBar(text: $searchText, onSearchButtonClicked: {
                viewModel.searchForLocation(searchText: searchText)
            })
            .padding(.horizontal, 16)
            
            // Map View
            Map(coordinateRegion: $viewModel.region, interactionModes: .all, annotationItems: viewModel.selectedCoordinates) { coord in
                MapPin(coordinate: coord.coordinate)
            }
            .cornerRadius(16)
            .padding(.horizontal, 16)
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
        .navigationBarItems(trailing: NavigationLink {
            ConfirmNewBetView(viewModel: viewModel, showNewBet: $showNewBet)
        } label: {
            Text("次へ")
                .font(.headline)
                .foregroundColor(Color.orange)
        }.simultaneousGesture(TapGesture().onEnded {
            // Set the value here before navigation
            viewModel.locationName = locationName
        }))
    }
    
}
