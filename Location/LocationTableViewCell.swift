//
//  LocationTableViewCell.swift
//  VisitedLocations
//
//  Created by Hiba on 8/12/21.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var latLonLabel: UILabel!
    @IBOutlet var dateTime: UILabel!
    
    var model: LocationModel?
    func configure(viewModel: LocationModel) {
        self.model = viewModel
        setUpData()
    }
    
    private func setUpData() {
        guard let model = model else {
            return
        }
        cityLabel.text = model.city
        latLonLabel.text = model.location.description
        dateTime.text = model.getFormattedDate()
    }
}
