//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Yinzhe Ma on 10/20/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import Foundation
import Alamofire

class WeatherLocation {
    var name=""
    var coordinates=""
    
    func getWeather(){
        let weatherURL=urlBase+urlAPIKey+coordinates
        print(weatherURL)
        AF.request(weatherURL).responseJSON{
            response in print(response)
        }
    }
}
