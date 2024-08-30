//
//  Location.swift
//  Africa
//
//  Created by Thomas Mani on 16/09/23.
//

import Foundation
import MapKit

struct Location:Codable,Identifiable {
    var id: String
    var name: String
    var image: String
    var latitude: Double
    var longitude: Double
    
    //Computed property
    var location: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
