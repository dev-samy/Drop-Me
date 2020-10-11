//
//  VehicleAnnotation.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 1.09.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import MapKit

class VehicleAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
