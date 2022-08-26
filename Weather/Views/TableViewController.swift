//
//  TableViewController.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import UIKit

class TableViewController: UITableViewController {
    
    var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        request(viewModel: viewModel)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.dateLabel.text = (viewModel.welcome.value?[indexPath.row].date) ?? ""
        cell.tempLabel.text = "\(viewModel.welcome.value?[indexPath.row].maxTempC ?? 0)°C"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "segueOne" else {return}
        let nC = segue.destination as! ViewController
        let indexPath = tableView.indexPathForSelectedRow!
        nC.selectedDate = viewModel.welcome.value?[indexPath.row]
    }
}
