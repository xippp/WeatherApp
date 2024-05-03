//
//  ShowDailyWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Paul on 3/5/2567 BE.
//

import UIKit

class ShowDailyWeatherTableViewCell: UITableViewCell {

//    MARK: -IBOutlet Property
    
    var setFirstText: String = "" {
        didSet {
            firstLabel.text = setFirstText
        }
    }
    
    var setMidText: String = "" {
        didSet {
            midLabel.text = setFirstText
        }
    }
    
    var setLastText: String = "" {
        didSet {
            lastLabel.text = setFirstText
        }
    }
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var midLabel: UILabel!
    
    @IBOutlet weak var lastLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
