//
//  ViewController.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var imageView = UIImageView()
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 40)
        label.textColor = .white
        label.backgroundColor = .systemPink
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        return label
    }()
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        return label
    }()
    
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        view.backgroundColor = .systemBackground
        addingSubviews()
        subviewsConstraints()
    }
    
    func update() {
        temperatureLabel.text = " \(self.viewModel.getSelectedDate().maxTempC)°C "
        descriptionLabel.text = self.viewModel.getSelectedDate().condition
        sunriseLabel.text = "Sunrise: \(self.viewModel.getSelectedDate().sunrise)"
        sunsetLabel.text = "Sunset: \(self.viewModel.getSelectedDate().sunset)"
        guard let url = URL(string: "https:" + (self.viewModel.getSelectedDate().icon)) else { return }
        imageView.loadFrom(url: url)
    }
    
    func addingSubviews() {
        view.addSubview(imageView)
        view.addSubview(temperatureLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(sunriseLabel)
        view.addSubview(sunsetLabel)
    }
    
    func subviewsConstraints() {
        imageViewConstraints()
        temperatureLabelConstraints()
        descriptionLabelConstraints()
        sunriseLabelConstraints()
        sunsetLabelConstraints()
    }
    
    func imageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
    }
    
    func temperatureLabelConstraints() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
    }
    
    func descriptionLabelConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 30).isActive = true
    }
    
    func sunriseLabelConstraints() {
        sunriseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunriseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sunriseLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    func sunsetLabelConstraints() {
        sunsetLabel.translatesAutoresizingMaskIntoConstraints = false
        sunsetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sunsetLabel.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: 5).isActive = true
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
