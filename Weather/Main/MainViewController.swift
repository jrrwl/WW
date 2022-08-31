//
//  MainViewController.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import UIKit

class MainViewController: UITableViewController {
    
    var viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.request()
        viewModel.welcome.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.welcome.value?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherViewCell
        guard let cellData = viewModel.welcome.value?[indexPath.row] else { return UITableViewCell.init() }
                
        let cellViewModel = WeatherCellViewModel(weaterModel: cellData)
                                                       
        cell.viewModel = cellViewModel
        cell.config()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "segueOne" else {return}
        let nC = segue.destination as! DetailViewController
        let indexPath = tableView.indexPathForSelectedRow!
        guard let selected = viewModel.welcome.value?[indexPath.row] else { return }
        let viewModel = DetailViewModel.init(selectedDate: selected)
        nC.viewModel = viewModel
    }
}
