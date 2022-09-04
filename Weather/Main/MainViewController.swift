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
        tableView.register(WeatherViewCell.self, forCellReuseIdentifier: "cell")
        self.title = "Warsaw Weather"
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nC = DetailViewController()
        guard let selected = viewModel.welcome.value?[indexPath.row] else { return }
        let viewModel = DetailViewModel.init(selectedDate: selected)
        nC.viewModel = viewModel
        navigationController?.pushViewController(nC, animated: true)
    }
}
