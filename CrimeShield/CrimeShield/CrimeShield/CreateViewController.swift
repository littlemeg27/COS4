//
//  CreateViewController.swift
//  CrimeShield
//
//  Created by Brenna Pavlinchak on 1/16/25.
//

import UIKit

class CreateViewController: UIViewController
{
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
    }

    @objc func saveData()
    {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let selectedDate = formatDate(date: datePicker.date)

        let report = Report(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, selectedDate: selectedDate)

        saveReportToUserDefaults(report)
        
        let alertController = UIAlertController(title: "Saved", message: "The Report has been Saved!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            {
                _ in    LONG_BIT
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(okAction)

        let tableVC = SentReportsViewController()
        navigationController?.pushViewController(tableVC, animated: true)
    }

    func formatDate(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }

    func saveReportToUserDefaults(_ report: Report)
    {
        var savedReports = fetchReportsFromUserDefaults()
        savedReports.append(report.toDictionary())
        UserDefaults.standard.set(savedReports, forKey: "savedReports")
    }

    func fetchReportsFromUserDefaults() -> [[String: String]]
    {
        return UserDefaults.standard.array(forKey: "savedReports") as? [[String: String]] ?? []
    }
}

struct Report
{
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let selectedDate: String

    func toDictionary() -> [String: String]
    {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "phoneNumber": phoneNumber,
            "selectedDate": selectedDate
        ]
    }

    init?(from dictionary: [String: String])
    {
        guard let firstName = dictionary["firstName"],
              let lastName = dictionary["lastName"],
              let phoneNumber = dictionary["phoneNumber"],
              let selectedDate = dictionary["selectedDate"] else
        {
            return nil
        }
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.selectedDate = selectedDate
    }

    init(firstName: String, lastName: String, phoneNumber: String, selectedDate: String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.selectedDate = selectedDate
    }
}
