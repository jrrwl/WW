//
//  ViewController.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageView = UIImageView()
    var temperatureLabel = UILabel()
    var descriptionLabel = UILabel()
    var sunriseLabel = UILabel()
    var sunsetLabel = UILabel()
    
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        view.backgroundColor = .systemBackground
        imageViewSettings()
        temperatureLabelSettings()
        descriptionLabelSettings()
        sunriseLabelSettings()
        sunsetLabelSettings()
    }
    
    func update() {
        temperatureLabel.text = " \(self.viewModel.getSelectedDate().maxTempC)°C "
        descriptionLabel.text = self.viewModel.getSelectedDate().condition
        sunriseLabel.text = "Sunrise: \(self.viewModel.getSelectedDate().sunrise)"
        sunsetLabel.text = "Sunset: \(self.viewModel.getSelectedDate().sunset)"
        guard let url = URL(string: "https:" + (self.viewModel.getSelectedDate().icon)) else { return }
        imageView.loadFrom(url: url)
    }
    
    func imageViewSettings() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    }
    
    func temperatureLabelSettings() {
        view.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        temperatureLabel.font = UIFont.italicSystemFont(ofSize: 40)
        temperatureLabel.textColor = .white
        temperatureLabel.backgroundColor = .systemPink
    }
    
    func descriptionLabelSettings() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.font = UIFont.systemFont(ofSize: 30)
    }
    
    func sunriseLabelSettings() {
        view.addSubview(sunriseLabel)
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sunriseLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        sunriseLabel.font = UIFont.systemFont(ofSize: 17, weight: .thin)
    }
    
    func sunsetLabelSettings() {
        view.addSubview(sunsetLabel)
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 5).isActive = true
        sunsetLabel.font = UIFont.systemFont(ofSize: 17, weight: .thin)
    }
    
}

extension UIImageView {
    func loadFrom(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
