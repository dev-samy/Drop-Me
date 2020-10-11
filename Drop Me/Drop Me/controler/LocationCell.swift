//
//  LocationCell.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 31.08.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import UIKit
import MapKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var locationLine1label: UILabel!
    @IBOutlet weak var locationLine2Labe: UILabel!
    
    func update(location: Location) {
        locationLine1label.text = location.title
        locationLine2Labe.text = location.subtitle
    }
    
    func update(searchResult: MKLocalSearchCompletion) {
        locationLine1label.text = searchResult.title
        locationLine2Labe.text = searchResult.subtitle
    }
}
