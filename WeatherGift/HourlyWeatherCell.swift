//
//  HourlyWeatherCell.swift
//  WeatherGift
//
//  Created by Yinzhe Ma on 10/27/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let dateFormatter=DateFormatter()
    dateFormatter.dateFormat="ha"
    return dateFormatter
}()

class HourlyWeatherCell: UICollectionViewCell {
    @IBOutlet weak var hourlyTime: UILabel!
    @IBOutlet weak var hourlyTemp: UILabel!
    @IBOutlet weak var hourlyPrecipProb: UILabel!
    @IBOutlet weak var hourlyIcon: UIImageView!
    @IBOutlet weak var rainDropImage: UIImageView!
    
    func update(with hourlyForecast: WeatherDetail.HourlyForecast, timeZone: String){
        hourlyIcon.image=UIImage(named: "small-"+hourlyForecast.hourlyIcon)
        hourlyTemp.text=String(format:"%2.f", hourlyForecast.hourlyTemeprature)+"°"
        let precipProb=hourlyForecast.hourlyPrecipProb*100
        let isHidden=precipProb<30
        hourlyPrecipProb.isHidden=isHidden
        rainDropImage.isHidden=isHidden
        hourlyPrecipProb.text=String(format: "%2.f", precipProb)+"%"
        let dateString=hourlyForecast.hourlyTime.format(timeZone: timeZone, dateFormatter: dateFormatter)
       hourlyTime.text=dateString
    }
}
