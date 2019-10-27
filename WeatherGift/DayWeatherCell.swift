//
//  DayWeatherCell.swift
//  WeatherGift
//
//  Created by Yinzhe Ma on 10/27/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import UIKit

class DayWeatherCell: UITableViewCell {

    @IBOutlet weak var dayCellMinTemp: UILabel!
    @IBOutlet weak var dayCellMaxTemp: UILabel!
    @IBOutlet weak var dayCellWeekday: UILabel!
    @IBOutlet weak var dayCellIcon: UIImageView!
    @IBOutlet weak var dayCellSummary: UITextView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
