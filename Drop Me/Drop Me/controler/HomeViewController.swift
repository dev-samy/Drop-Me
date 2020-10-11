//
//  HomeViewController.swift
//  Drop Me
//
//  Created by Abdelrahman Samy on 31.08.2020.
//  Copyright © 2020 Abdelrahman Samy. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate{

    @IBOutlet weak var SearchBuuton: UIButton!
    
    var locations = [Location]()
    var locationManger: CLLocationManager!
    var currentUserLocation: Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButtonConfg()
        
        let recentLocation = LocationService.shared.getRecentLocation()
        
        locations = [recentLocation[0], recentLocation[1]]
        
        locationManger = CLLocationManager()
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManger.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let locationViewController = segue.destination as? LocationViewController {
            locationViewController.pickupLocation = currentUserLocation
        } else if let routeViewController = segue.destination as? RouteViewController, let dropoffLocation = sender as? Location {
            routeViewController.pickupLocation = currentUserLocation
            routeViewController.dropoffLocation = dropoffLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let firstLocation = locations.first!
        currentUserLocation = Location(title: "Current Location", subtitle: "", lat: firstLocation.coordinate.latitude, lng: firstLocation.coordinate.longitude)
        locationManger.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManger.startUpdatingLocation()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        let location = locations[indexPath.row]
        cell.update(location: location)
        return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dropoffLocation = locations[indexPath.row]
        performSegue(withIdentifier: "RouteSegu", sender: dropoffLocation)
    }
    
    func searchButtonConfg() {
        SearchBuuton.layer.cornerRadius = 10.0
        SearchBuuton.layer.shadowRadius = 1.0
        SearchBuuton.layer.shadowColor = UIColor.black.cgColor
        SearchBuuton.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        SearchBuuton.layer.shadowOpacity = 0.5
    }
    

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        // zoom in to user location
        let distance = 200.0
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        
        // create 3 vehicle and add them to mapView
        let lat = userLocation.coordinate.latitude
        let lng = userLocation.coordinate.longitude
        let offset = 0.00075
        let coord1 = CLLocationCoordinate2D(latitude: lat-offset, longitude: lng-offset)
        let coord2 = CLLocationCoordinate2D(latitude: lat, longitude: lng+offset)
        let coord3 = CLLocationCoordinate2D(latitude: lat, longitude: lng-offset)
        
        mapView.addAnnotations([
            VehicleAnnotation(coordinate: coord1),
            VehicleAnnotation(coordinate: coord2),
            VehicleAnnotation(coordinate: coord3)
        ])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        //create our custom annotaion view with vehicle image
        let reuseIdentifier = "VehicleAnnotaion"
        var annitaionView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        if annitaionView == nil {
            annitaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }else {
            annitaionView?.annotation = annotation
        }
        annitaionView?.image = UIImage(named: "car")
        annitaionView?.transform = CGAffineTransform(rotationAngle: CGFloat(arc4random_uniform(360)*180) / CGFloat.pi )
        return annitaionView
    }

}
 
// 40.976122,28.711218
