//
//  Accountpage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-25.
//

import Foundation
import UIKit

class AccountpageController: UIViewController {
    

    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var aboutTextField: UITextField!
    
    @IBOutlet weak var intrestTextField: UITextField!
    
    @IBOutlet weak var FromAge: UITextField!
    
    @IBOutlet weak var ToAge: UITextField!
    
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var CampusTextField: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var SelectGender: UITextField!
    

    @IBOutlet weak var notificationButton: UIButton!
    
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
    
    override func viewDidLoad() {
            super.viewDidLoad()
            updateButton.applyGradient()
              
        // Apply the corner radius
                userTextField.layer.cornerRadius = 25
                mobileTextField.layer.cornerRadius = 25
                intrestTextField.layer.cornerRadius = 25
        
        // Apply border to text fields
        userTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        mobileTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        intrestTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        birthdayTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        CampusTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        SelectGender.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        aboutTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        FromAge.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        ToAge.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
            }
    
    
    
}
