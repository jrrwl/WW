//
//  ViewController.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var tempLabelOutlet: UILabel!
    @IBOutlet weak var descriptionOutlet: UILabel!
    @IBOutlet weak var sunriseLabelOutlet: UILabel!
    @IBOutlet weak var sunsetLabelOutlet: UILabel!
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    func update() {
        tempLabelOutlet.text = "\(self.viewModel.getSelectedDate().maxTempC)°C"
        descriptionOutlet.text = self.viewModel.getSelectedDate().condition
        sunriseLabelOutlet.text = "Sunrise: \(self.viewModel.getSelectedDate().sunrise)"
        sunsetLabelOutlet.text = "Sunset: \(self.viewModel.getSelectedDate().sunset)"
        guard let url = URL(string: "https:" + (self.viewModel.getSelectedDate().icon)) else { return }
        imageOutlet.loadFrom(url: url)
    }
    
    
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
