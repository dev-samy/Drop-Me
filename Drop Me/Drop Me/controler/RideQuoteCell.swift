//
//  RideQuoteCell.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 17.09.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import UIKit

class RideQuoteCell: UITableViewCell {

    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func update(rideQuore: RideQuote) {
        thumnailImageView.image = UIImage(named: rideQuore.thumbnail)
        titleLabel.text = rideQuore.name
        capacityLabel.text = rideQuore.capacity
        priceLabel.text = String(format: "$%.2f", rideQuore.price)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mma"
        
        timeLabel.text = dateFormatter.string(from: rideQuore.time)
    }
    
    func updateSelcetStatus(status: Bool) {
        if status{
            contentView.layer.cornerRadius = 5.0
            contentView.layer.borderWidth = 2.0
            contentView.layer.borderColor = UIColor(red: 161/255.0, green: 48/255.0, blue: 63/255.0, alpha: 1.0).cgColor
    }
        else {
            contentView.layer.borderWidth = 0.0
        }

}
}
