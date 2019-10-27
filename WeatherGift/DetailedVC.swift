//
//  DetailedVC.swift
//  WeatherGift
//
//  Created by Yinzhe Ma on 10/12/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import UIKit
import CoreLocation

private let dateFormatter: DateFormatter = {
    let dateFormatter=DateFormatter()
    dateFormatter.dateFormat="EEEE, MMM dd, y"
    return dateFormatter
}()

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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        collectionView.delegate=self
        collectionView.dataSource=self
        if currentPage != 0 {
            self.locationsArray[currentPage].getWeather{
                self.updateUserInterface()
            }
        }
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
        let location=locationsArray[currentPage]
        locationLabel.text=location.name
        let dateString=location.currentTime.format(timeZone: location.timeZone, dateFormatter: dateFormatter)
        dateLabel.text=dateString
        tempLabel.text=location.currentTemperature
        summaryLabel.text=location.currentSummary
        currentImage.image=UIImage(named: location.currentIcon)
        tableView.reloadData()
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
            self.locationsArray[0].getWeather{
                self.updateUserInterface()
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location")
    }
    
    
}

extension DetailedVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsArray[currentPage].dailyForecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
        let dailyForecast=locationsArray[currentPage].dailyForecastArray[indexPath.row]
        let timeZone=locationsArray[currentPage].timeZone
        cell.update(with: dailyForecast, timeZone: timeZone)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

extension DetailedVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourlyCell=collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCell", for: indexPath)
        return hourlyCell
    }
    
    
}
