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
    
    
    @IBAction func updateButtonClicked(_ sender: UIButton) {
        guard let ID = getUserID() else {
            print("User ID not found")
            return
        }

        let updateUrlString = "https://e-invite.site/updateUser.php"
        guard let updateUrl = URL(string: updateUrlString) else {
            print("Invalid update URL")
            return
        }

        var request = URLRequest(url: updateUrl)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        // Create URL-encoded parameters
        let updatePostString = "id=\(ID)" +
            "&name=\(userTextField.text ?? "")" +
            "&bio=\(aboutTextField.text ?? "")" +
            "&fromage=\(FromAge.text ?? "")" +
            "&toage=\(ToAge.text ?? "")" +
            "&birthdate=\(dateFormatter.string(from: dobPicker.date))" +
            "&gender=\(genderData[genderPicker.selectedRow(inComponent: 0)])" +
            "&preferred_gender=\(genderData[interestedPicker.selectedRow(inComponent: 0)])" +
            "&campus=\(campusOptions[campusPicker.selectedRow(inComponent: 0)])"

        request.httpBody = updatePostString.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating user: \(error.localizedDescription)")
                return
            }

            if let data = data {
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Update response:\n\(dataString)")

                    // Handle the update response as needed
                    // You might want to check for success or show an alert to the user
                }
            }
        }.resume()
    }

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
        
        
        // Apply border to text fields
        userTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
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

    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd" // Adjust the date format based on your API response
            return formatter
        }()
    
    func updateUI(with user: [String: Any]) {
        // Update UI elements with user details
        userTextField.text = user["name"] as? String
        // Update other fields similarly
        // For example:
        aboutTextField.text = user["bio"] as? String
        FromAge.text = "\(user["fromage"] as? Int ?? 0)"
        ToAge.text = "\(user["toage"] as? Int ?? 0)"
        
        // Update date picker if user has birthdate
        if let birthdateString = user["birthdate"] as? String,
           let birthdate = dateFormatter.date(from: birthdateString) {
            dobPicker.date = birthdate
        }

        // Update gender picker if user has gender information
        if let genderString = user["gender"] as? String,
           let genderIndex = genderData.firstIndex(of: genderString) {
            genderPicker.selectRow(genderIndex, inComponent: 0, animated: true)
        }

        // Update campus picker if user has campus information
        if let campusString = user["campus"] as? String,
           let campusIndex = campusOptions.firstIndex(of: campusString) {
            campusPicker.selectRow(campusIndex, inComponent: 0, animated: true)
        }
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
