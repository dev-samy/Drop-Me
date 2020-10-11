//
//  LocationViewController.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 4.09.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MKLocalSearchCompleterDelegate {
   
    var locations = [Location]()
    var pickupLocation: Location!
    var dropLocation: Location!
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dropOffTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locations = LocationService.shared.getRecentLocation()
        
        dropOffTextField.becomeFirstResponder()
        
        searchCompleter.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
           navigationController?.isNavigationBarHidden = false
       }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let latestString = (textField.text as! NSString).replacingCharacters(in: range, with: string)
        print("latest string \(latestString)")
        
        if latestString.count > 3 {
            searchCompleter.queryFragment = latestString
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.isEmpty ? locations.count : searchResults.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        
        if searchResults.isEmpty {
            let location = locations[indexPath.row]
            cell.update(location: location)
        } else {
            let searchResult = searchResults[indexPath.row]
            cell.update(searchResult: searchResult)
        }
        return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchResults.isEmpty{
            let location = locations[indexPath.row]
            performSegue(withIdentifier: "RouteSegu", sender: location)
        } else {
            // Convert searchResult -> Location object
            let searchResult = searchResults[indexPath.row]
            let searchRequest = MKLocalSearch.Request(completion: searchResult)
            let search = MKLocalSearch(request: searchRequest)
            search.start(completionHandler: { (response, error) in
                if error == nil{
                    if let dropoffPlacemark = response?.mapItems.first?.placemark{
                        let location = Location(placemark: dropoffPlacemark)
                        self.performSegue(withIdentifier: "RouteSegu", sender: location)
                    }
                }
            })
        }
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
    
    @IBAction func cancelBuuton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let routeViewController = segue.destination as? RouteViewController, let dropoffLocation = sender as? Location{
               routeViewController.pickupLocation = pickupLocation
               routeViewController.dropoffLocation = dropoffLocation
           }
       }
    

}
