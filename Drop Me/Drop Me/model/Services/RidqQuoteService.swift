//
//  RidqQuoteService.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 31.08.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import Foundation
import CoreLocation

class RideQuoteService {
    static let shared = RideQuoteService()
    
    private init(){}
    
    func getQuote(pickupLocation: Location, dropoffLocation: Location) -> [RideQuote] {
        let location1 = CLLocation(latitude: pickupLocation.lat, longitude: dropoffLocation.lng)
        let location2 = CLLocation(latitude: dropoffLocation.lat, longitude: pickupLocation.lng)
        
        let distance = location1.distance(from: location2)
        let minimumAmount = 3.0
        
        return [
            RideQuote(thumbnail: "ride-shared", name: "Shared", capacity: "1-2", price: minimumAmount + (distance * 0.005), time: Date()),
            RideQuote(thumbnail: "ride-compact", name: "Compact", capacity: "4", price: minimumAmount + (distance * 0.009), time: Date()),
            RideQuote(thumbnail: "ride-large", name: "Large", capacity: "6", price: minimumAmount + (distance * 0.015), time: Date())
        ]
    }
    
}
