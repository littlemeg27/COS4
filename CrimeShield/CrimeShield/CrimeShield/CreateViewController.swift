//
//  CreateViewController.swift
//  CrimeShield
//
//  Created by Brenna Pavlinchak on 1/16/25.
//

import AVFoundation
import UIKit

class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var reportInfoTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func cameraButtonTapped(_ sender: UIButton)
    {
        openCamera()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        checkCameraPermission()
        
        reportInfoTextView!.layer.borderWidth = 1
        reportInfoTextView!.layer.borderColor = UIColor.lightGray.cgColor
    }

    @objc func saveData()
    {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let selectedDate = formatDate(date: datePicker.date)
        let reportInfo = reportInfoTextView.text ?? ""

        let report = Report(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, reportInfo: reportInfo, selectedDate: selectedDate)

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
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            print("Camera not available on this device.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let selectedImage = info[.editedImage] as? UIImage
        {
            print("Image selected: \(selectedImage)")
        }
        else if let originalImage = info[.originalImage] as? UIImage
        {
            print("Original Image: \(originalImage)")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}

func checkCameraPermission()
{
    let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
    
    switch cameraStatus
    {
    case .authorized:
        print("Camera access granted")
    case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted
            {
                print("Camera access granted")
            }
            else
            {
                print("Camera access denied")
            }
        }
    case .denied, .restricted:
        print("Camera access denied. Ask the user to enable it in settings.")
    @unknown default:
        fatalError("Unknown camera permission status")
    }
}

struct Report
{
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let reportInfo: String
    let selectedDate: String

    func toDictionary() -> [String: String]
    {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "phoneNumber": phoneNumber,
            "reportInfo": reportInfo,
            "selectedDate": selectedDate
        ]
    }

    init?(from dictionary: [String: String])
    {
        guard let firstName = dictionary["firstName"],
              let lastName = dictionary["lastName"],
              let phoneNumber = dictionary["phoneNumber"],
              let reportInfo = dictionary["reportInfo"],
              let selectedDate = dictionary["selectedDate"] else
        {
            return nil
        }
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.reportInfo = reportInfo
        self.selectedDate = selectedDate
    }

    init(firstName: String, lastName: String, phoneNumber: String, reportInfo: String, selectedDate: String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.reportInfo = reportInfo
        self.selectedDate = selectedDate
    }
}
