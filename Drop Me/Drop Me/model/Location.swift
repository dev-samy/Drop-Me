//
//  Location.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 28.08.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import Foundation
import MapKit

class Location: Codable{
    var title: String
    var subtitle: String
    let lat: Double
    let lng: Double
    
    init(title: String, subtitle:String, lat: Double, lng: Double) {
        self.title = title
        self.subtitle = subtitle
        self.lat = lat
        self.lng = lng
    }
    
    init(placemark: MKPlacemark){
        self.title = placemark.name ?? ""
        self.subtitle = placemark.title ?? ""
        self.lat = placemark.coordinate.latitude
        self.lng = placemark.coordinate.longitude
    }
}
