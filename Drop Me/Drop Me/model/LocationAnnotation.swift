//
//  LocationAnnotation.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 10.10.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    let locationType: String
    
    init(coordinate: CLLocationCoordinate2D, locationType: String) {
        self.coordinate = coordinate
        self.locationType = locationType
    }
    
}
