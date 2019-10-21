//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Yinzhe Ma on 10/20/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name=""
    var coordinates=""
    var currentTemperature="--"
    var currentSummary=""
    var currentIcon=""
    
    func getWeather(completed: @escaping()->()){
        let weatherURL=urlBase+urlAPIKey+coordinates
        AF.request(weatherURL).responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json=JSON(value)
                if let temperature=json["currently"]["temperature"].double{
                    let roundedTemp=String(format:"%3.f", temperature)
                    self.currentTemperature=roundedTemp+"°"
                } else{
                    print("Could not return a temperature")
                }
                if let summary = json["daily"]["summary"].string{
                    self.currentSummary=summary
                } else{
                    print("Could not return a summary")
                }
                if let icon = json["currently"]["icon"].string{
                    self.currentIcon=icon
                } else{
                    print("Could not find an icon")
                }
            case .failure(let error):
                print(error)
            }
            completed()
        } 
    }
}
