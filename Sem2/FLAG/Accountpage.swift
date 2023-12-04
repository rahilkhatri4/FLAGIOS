//
//  Accountpage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-25.
//

import Foundation
import UIKit

class AccountpageController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var aboutTextField: UITextField!
        
    @IBOutlet weak var FromAge: UITextField!
    
    @IBOutlet weak var ToAge: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!

    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var dobPicker: UIDatePicker!
    
    @IBOutlet weak var campusPicker: UIPickerView!
    
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var interestedPicker: UIPickerView!
    
    @IBOutlet weak var GobackButton: UIButton!
    
//    @IBAction func previousButtonTapped(_ sender: UIButton) {
//           // Navigate to the "Homepage" view controller
//           if let ConnectionspageViewController = UIStoryboard(name: "Main", bundle: nil)
//               .instantiateViewController(withIdentifier: "ConnectionspageController") as? ConnectionspageController {
//               navigationController?.pushViewController(ConnectionspageViewController, animated: true)
//           }
//       }
    
    
    @IBAction func gobackButtonTapped(_ sender: UIButton) {
        // Navigate back to the previous view controller
        navigationController?.popViewController(animated: true)
        }
    
    @IBAction func notificationButtonTapped(_ sender: UIButton) {
        // Navigate to the NotificationViewController
        
        // Instantiate the NotificationViewController using the correct identifier
        if let notificationController = storyboard?.instantiateViewController(withIdentifier: "NotificationViewpage") as? NotificationViewController {
            navigationController?.pushViewController(notificationController, animated: true)
        }
        }
    let genderData = ["Men" , "Women" , "Other"]
    
    let campusOptions = ["Barrie", "Midland", "Muskoka", "Orangeville", "Orillia" , "Owen Sound", "South Georgian Bay"]
    
    override func viewDidLoad() {
            super.viewDidLoad()
            updateButton.applyGradient()
              
        // Apply the corner radius
                userTextField.layer.cornerRadius = 25
                mobileTextField.layer.cornerRadius = 25
        
        
        // Apply border to text fields
        userTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        mobileTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
//        intrestTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
//        birthdayTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
//        CampusTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
//        SelectGender.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        aboutTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        FromAge.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        ToAge.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        
        dobPicker.datePickerMode = .date
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        interestedPicker.delegate = self
        interestedPicker.dataSource = self
        
        campusPicker.delegate = self
        campusPicker.dataSource = self
        
        fetchUserDetails()
            }
    
    func getUserID() -> Int? {
        return UserDefaults.standard.integer(forKey: "ID")
    }
    
    func fetchUserDetails() {
            if let ID = getUserID() {
                guard let url = URL(string: "https://e-invite.site/getUser.php?id=\(ID)") else {
                    print("Invalid URL")
                    return
                }

                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }

                    if let data = data {
                        // Print the received data (for debugging purposes)
                        if let dataString = String(data: data, encoding: .utf8) {
                            print("Received Data:\n\(dataString)")
                        }
                        do {
                            if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let success = jsonDictionary["success"] as? Bool, success,
                               let user = jsonDictionary["user"] as? [String: Any] {
                                // Update UI on the main thread
                                DispatchQueue.main.async {
                                    self.updateUI(with: user)
                                }
                            }
                        } catch let error {
                            print("Error decoding response: \(error.localizedDescription)")
                        }
                    }
                }.resume()
            } else {
                print("User ID not found")
            }
        }

        func updateUI(with user: [String: Any]) {
            // Update UI elements with user details
            userTextField.text = user["name"] as? String
            // Update other fields similarly
        }


    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView == genderPicker || pickerView == interestedPicker{
                return genderData.count
            } else if pickerView == campusPicker {
                return campusOptions.count
            } else {
                // Handle other pickers if needed
                return 0
            }
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == genderPicker || pickerView == interestedPicker{
                return genderData[row]
            } else if pickerView == campusPicker {
                return campusOptions[row]
            } else {
                // Handle other pickers if needed
                return nil
            }
        }
    
    
    
}
