//
//  DetailViewController.swift
//  CrimeShield
//
//  Created by Brenna Pavlinchak on 1/23/25.
//

import UIKit

class DetailViewController: UIViewController
{
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var report: Report?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        guard let report = report else { return }
        
        firstNameLabel.text = "Party: \(report.firstName)"
        lastNameLabel.text = "Party: \(report.lastName)"
        phoneNumberLabel.text = "Title: \(report.phoneNumber)"
        dateLabel.text = "State: \(report.selectedDate)"
    }
}
