import SwiftUI
import MapKit

struct EventView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.66719808299951, longitude: 139.74010893973326),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    let date: Date
    init() {
        self.date = Date()
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            // Time and Date Section
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 20))
                Spacer()
                Text(formattedDate(date: date))
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Text("1分後")
                    .font(.system(size: 12))
                    .foregroundColor(.orange)
            }
            .padding(.horizontal)
            .padding(.top, 20)

            // Location Section
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.orange)
                    .font(.system(size: 20))
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("アーク森ビル")
                        .font(.system(size: 16, weight: .semibold))
                    Text("0.1 km")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Map Section
            Map(coordinateRegion: $region)
                .frame(height: 150)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 10)

            // Confirmation Button
            Button(action: {
                // Action for map confirmation
            }) {
                Text("マップで確認する")
                    .font(.system(size: 16, weight: .semibold))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .padding()
        .shadow(radius: 5)
    }
}
func formattedDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    // Set the time format
    dateFormatter.dateFormat = "h:mm a"
    let timeString = dateFormatter.string(from: date)
    
    // Set the date format
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let dateString = dateFormatter.string(from: date)
    
    return "\(timeString) - \(dateString)"
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
