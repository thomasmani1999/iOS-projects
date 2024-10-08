//
//  InsetMapView.swift
//  Africa
//
//  Created by Thomas Mani on 14/09/23.
//

import SwiftUI
import MapKit

struct InsetMapView: View {
    
    @State private var region = MKCoordinateRegion (center: CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.437759), span: MKCoordinateSpan(latitudeDelta: 60.0, longitudeDelta: 60.0))
    
    var body: some View {
        Map(coordinateRegion: $region)
            .overlay(alignment: .topTrailing, content: {
                NavigationLink {
                    MapView()
                } label: {
                    HStack {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(.white)
                            .imageScale(.large)
                        
                        Text("Locations")
                            .foregroundColor(.accentColor)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,14)
                    .background(
                        Color.black
                            .opacity(0.4)
                            .cornerRadius(9)
                    )
                }
                .padding(12)
            })
            .frame(height: 256)
            .cornerRadius(12)
    }
}

struct InsetMapView_Previews: PreviewProvider {
    static var previews: some View {
        InsetMapView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
