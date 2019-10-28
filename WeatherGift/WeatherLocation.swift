//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Yinzhe Ma on 10/27/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import Foundation

class WeatherLocation: Codable{
    var name=""
    var coordinates=""
    
    init(name: String, coordinates: String){
        self.name=name
        self.coordinates=coordinates
        
    }
    
}
