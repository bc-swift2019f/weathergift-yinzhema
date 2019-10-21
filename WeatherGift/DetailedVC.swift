//
//  DetailedVC.swift
//  WeatherGift
//
//  Created by Yinzhe Ma on 10/12/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import UIKit
import CoreLocation

class DetailedVC: UIViewController {

    var currentPage=0
    var locationsArray=[WeatherLocation]()
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text=locationsArray[currentPage].name
        dateLabel.text=locationsArray[currentPage].coordinates
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentPage==0 {
            getLocation()
        }
    }
    
    func updateUserInterface(){
        locationLabel.text=locationsArray[currentPage].name
        dateLabel.text=locationsArray[currentPage].coordinates
    }
}

extension DetailedVC: CLLocationManagerDelegate{
    
    func getLocation(){
        locationManager=CLLocationManager()
        locationManager.delegate=self
        let status=CLLocationManager.authorizationStatus()
        handleLocationAuthorizationStatus(status: status)
    }
    
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus){
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            print("I'm sorry - can't show location. User has not authorized it.")
        case .restricted:
            print("Access denied. Likely parental controls are restrict location services in this app.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder=CLGeocoder()
        var place=""
        currentLocation=locations.last
        let currentLatitude=currentLocation.coordinate.latitude
        let currentLongitude=currentLocation.coordinate.longitude
        let currentCoordinates="\(currentLatitude),\(currentLongitude)"
        dateLabel.text=currentCoordinates
        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: {placemarks, error in
            if placemarks != nil{
                let placemark=placemarks?.last
                place=(placemark?.name!)!
            } else{
                print("Error retrieving place. Error code: \(error!)")
                place="Unknown Weather Location"
            }
            self.locationsArray[0].name=place
            self.locationsArray[0].coordinates=currentCoordinates
            self.locationsArray[0].getWeather()
            self.updateUserInterface()
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location")
    }
    
    
}
