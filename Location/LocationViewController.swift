//
//  LocationViewController.swift
//  VisitedLocations
//
//  Created by Hiba on 8/12/21.
//

import UIKit

protocol LocationViewDelegate: AnyObject {
    func displayError(message: String)
    func reloadTableView()
}

class LocationViewController: UIViewController {
    
    @IBOutlet var locationsTableView: UITableView!
    var viewModel = LocationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Visited Locations"
    }

}

extension LocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "LocationCellIdentifier",
            for: indexPath
        ) as? LocationTableViewCell else {
            fatalError("Cell not found")
        }
        cell.configure(viewModel: viewModel.locationsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewModel.deleteItemAt(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}


extension LocationViewController: LocationViewDelegate {
    
    func displayError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let alert = UIAlertController(title: "Weather data fetch Failed", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.locationsTableView.reloadData()
        }
    }
}
