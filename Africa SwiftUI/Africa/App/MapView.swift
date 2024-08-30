//
//  MapView.swift
//  Africa
//
//  Created by Thomas Mani on 10/09/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 70.0, longitudeDelta: 70.0)
        return MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
    }()
    
    let locations:[Location] = Bundle.main.decode("locations.json")
    
    var body: some View {
        Map(coordinateRegion: $region,annotationItems: locations) { location in
            //MapMarker(coordinate: location.location,tint: .accentColor)
        
            
//            MapAnnotation(coordinate: location.location) {
//                Image(location.image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 32, height: 32, alignment: .center)
//            }
            
            MapAnnotation(coordinate: location.location) {
                MapAnnotationView(location: location)
            }
        }
        .overlay(alignment:.top) {
            HStack(alignment: .center, spacing: 20) {
                Image("compass")
                    .resizable()
                    .scaledToFit()
                .frame(width: 48, height: 48, alignment: .center)
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text("Lattitude: ")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.latitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                    Divider()
                    HStack {
                        Text("Longitude: ")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text("\(region.center.longitude)")
                            .font(.footnote)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.vertical,12)
            .padding(.horizontal,16)
            .background {
                Color.black
                    .cornerRadius(8)
                    .opacity(0.6)
            }
            .padding()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
