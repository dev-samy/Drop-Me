//
//  DriverService.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 11.10.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class DriverService{
    static let shared = DriverService()
    
    private init(){}
    
    func getDriver(pickupLocation : Location) -> (Driver, Int){
        //let locations = LocationService.shared.getRecentLocation()
        //  let randomLocation = locations[Int(arc4random_uniform(UInt32(locations.count)))]
        //  40.974064, 28.713495
        let coordinate = CLLocationCoordinate2D(latitude: 40.974064, longitude: 28.713495)
        let driver = Driver(name: "Abdelrahman Samy", thumbnail: "driver", licenseNumber: "7WB312S", rating: 5.0, car: "Hyundai Sonata", coordinate: coordinate)
        return (driver, 10)
    }
}
