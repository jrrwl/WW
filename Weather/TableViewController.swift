//
//  TableViewController.swift
//  Weather
//
//  Created by Vladimir Illukovich on 15.08.22.
//

import UIKit

class TableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        repeat {
            tableView.reloadData()
        } while publicWeatherData == nil
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publicWeatherData?.forecast?.forecastday?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.dateLabel.text = (publicWeatherData?.forecast?.forecastday?[indexPath.row].date) ?? ""
        cell.tempLabel.text = "\(publicWeatherData?.forecast?.forecastday?[indexPath.row].day?.maxtempC ?? 0)°C"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "segueOne" else {return}
        let nC = segue.destination as! ViewController
        let indexPath = tableView.indexPathForSelectedRow!
        nC.selectedDate = publicWeatherData?.forecast?.forecastday?[indexPath.row]
    }

}
