//
//  SentReportsViewController.swift
//  CrimeShield
//
//  Created by Brenna Pavlinchak on 1/16/25.
//

import UIKit

class SentReportsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    var savedReports: [Report] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()

        savedReports = fetchReportsFromUserDefaults().compactMap { Report(from: $0) }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PostCell")
    }

    func fetchReportsFromUserDefaults() -> [[String: String]]
    {
        return UserDefaults.standard.array(forKey: "savedReports") as? [[String: String]] ?? []
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return savedReports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let report = savedReports[indexPath.row]

        cell.textLabel?.text = "\(report.lastName), \(report.firstName) - \(report.selectedDate)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedReport = savedReports[indexPath.row]
        performSegue(withIdentifier: "ShowDetail", sender: selectedReport)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowDetail", let detailVC = segue.destination as? DetailViewController, let report = sender as? Report
        {
            detailVC.report = report
        }
    }
}
