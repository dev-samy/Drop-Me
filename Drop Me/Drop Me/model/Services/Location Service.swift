//
//  Location Service.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 28.08.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import Foundation

class LocationService {
    static let shared = LocationService()
    
    private var recentLocation = [Location]()
    
    private init() {
        let locationUrl = Bundle.main.url(forResource: "locations", withExtension: "json")!
        let data = try! Data(contentsOf: locationUrl)
        let decoder = JSONDecoder()
        recentLocation = try! decoder.decode([Location].self, from: data)
    }
    
    func getRecentLocation() -> [Location] {
        return recentLocation
    }
    
}
