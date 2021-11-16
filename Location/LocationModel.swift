//
//  LocationModel.swift
//  VisitedLocations
//
//  Created by Hiba on 8/12/21.
//

import Foundation

struct LocationModel: Codable {
    
    var location: Coordinate
    var city: String
    var dateTime: Date

   func getFormattedDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateStyle = .medium
        dateformat.timeStyle = .short
        return dateformat.string(from: dateTime)
    }
}

struct Coordinate: Codable, CustomStringConvertible {
    var lat: Double
    var lon: Double
    
    var description: String {
        return "\(lat), \(lon)"
    }
}
