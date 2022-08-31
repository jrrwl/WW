//
//  TableViewCell.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import UIKit

class WeatherViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var viewModel: WeatherCellViewModel?
    
    func config() {
        dateLabel.text = viewModel?.date
        tempLabel.text = "\(viewModel?.maxTempC ?? 0)°C"
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
