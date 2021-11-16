//
//  LocationViewModel.swift
//  VisitedLocations
//
//  Created by Hiba on 8/12/21.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, CLLocationManagerDelegate {
    var locationsArray = [LocationModel]()
    lazy var locationManager = CLLocationManager()
    weak var delegate: LocationViewDelegate?
    let dataManager = DataManager()

    override init() {
        super.init()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // locationManager.startUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways , .authorizedWhenInUse:
            getData()
            break
        case .notDetermined, .denied , .restricted:
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.displayError(message: error.localizedDescription)
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        getData()
//    }

    func getData() {
        if let data = dataManager.read(key: "Locations") {
            locationsArray = data
        }
        guard let  location = locationManager.location else {
            return
        }
        let lat = Double(round(1000*location.coordinate.latitude)/1000)
        let lon = Double(round(1000*location.coordinate.longitude)/1000)
        let coordinate = Coordinate(lat: lat, lon: lon)
        CLGeocoder().reverseGeocodeLocation(location) { placemark, error in
            guard let placemark = placemark,
                  placemark.count>0,
                  let city = placemark[0].locality else {
                print("Error:", error ?? "nil")
                return
            }
            self.locationsArray.append(
                LocationModel(location: coordinate, city: city, dateTime: Date())
            )
            self.dataManager.write(for: "Locations", data: self.locationsArray)
            self.delegate?.reloadTableView()
        }
    }
    
    func deleteItemAt(index: Int) {
        locationsArray.remove(at: index)
        delegate?.reloadTableView()
    }
}
