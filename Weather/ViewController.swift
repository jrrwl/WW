//
//  ViewController.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var tempLabelOutlet: UILabel!
    @IBOutlet weak var descriptionOutlet: UILabel!
    @IBOutlet weak var sunriseLabelOutlet: UILabel!
    @IBOutlet weak var sunsetLabelOutlet: UILabel!
    
    var selectedDate: Forecastday?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempLabelOutlet.text = "\(selectedDate?.day?.maxtempC ?? 0)°C "
        descriptionOutlet.text = selectedDate?.day?.condition?.text ?? ""
        sunriseLabelOutlet.text = "Sunrise: \(selectedDate?.astro?.sunrise ?? "")"
        sunsetLabelOutlet.text = "Sunset: \(selectedDate?.astro?.sunset ?? "")"
        guard let url = URL(string: "https:" + (selectedDate?.day?.condition?.icon)!) else { return }
        imageOutlet.loadFrom(url: url)
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
