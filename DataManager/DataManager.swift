//
//  DataManager.swift
//  VisitedLocations
//
//  Created by Hiba on 8/12/21.
//

import Foundation

class DataManager {
    var userDefault: UserDefaults
    init(_ userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }
    
    func read(key: String) -> [LocationModel]? {
        guard let items: Data = userDefault.data(forKey: key) else {
            return []
        }
        do {
            let decodedData = try JSONDecoder().decode([LocationModel].self, from: items)
            return decodedData
        } catch {
            return []
        }
    }
    func write(for key: String, data: [LocationModel]) {
        do {
            let data = try JSONEncoder().encode(data)
            userDefault.setValue(data, forKey: key)
        } catch {
            
        }
    }
}
