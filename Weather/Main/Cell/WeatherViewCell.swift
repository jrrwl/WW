//
//  TableViewCell.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import UIKit

class WeatherViewCell: UITableViewCell {
    
    var datelabel = UILabel()
    var temperatureLabel = UILabel()
    
    var viewModel: WeatherCellViewModel?
    
    func config() {
        datelabel.text = viewModel?.date
        temperatureLabel.text = "\(viewModel?.maxTempC ?? 0)°C"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(datelabel)
        addSubview(temperatureLabel)
        setDateLabelConstraints()
        setTemperatureLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDateLabelConstraints() {
        datelabel.translatesAutoresizingMaskIntoConstraints = false
        datelabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        datelabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
    
    func setTemperatureLabelConstraints() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    
}
