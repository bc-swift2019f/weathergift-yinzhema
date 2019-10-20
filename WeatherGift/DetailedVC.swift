//
//  DetailedVC.swift
//  WeatherGift
//
//  Created by Yinzhe Ma on 10/12/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import UIKit

class DetailedVC: UIViewController {

    var currentPage=0
    var locationsArray=[WeatherLocation]()
    
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
}
