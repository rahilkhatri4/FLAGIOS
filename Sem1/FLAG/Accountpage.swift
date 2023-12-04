//
//  Accountpage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-25.
//

import Foundation
import UIKit

class AccountpageController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var intrestTextField: UITextField!
    
    @IBOutlet weak var addintresetButton: UIButton!
    
    @IBOutlet weak var FromAge: UITextField!
    
    @IBOutlet weak var ToAge: UITextField!
    
    @IBOutlet weak var birthdayTextField: UITextField!
    
    @IBOutlet weak var CampusTextField: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var SelectGender: UITextField!
    
    
    
//    @IBAction func previousButtonTapped(_ sender: UIButton) {
//           // Navigate to the "Homepage" view controller
//           if let ConnectionspageViewController = UIStoryboard(name: "Main", bundle: nil)
//               .instantiateViewController(withIdentifier: "ConnectionspageController") as? ConnectionspageController {
//               navigationController?.pushViewController(ConnectionspageViewController, animated: true)
//           }
//       }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            updateButton.applyGradient()
        // Set the content mode to aspect fit (or any other mode you prefer)
               profilePicture.contentMode = .scaleToFill
               
               // Add the rounded border by setting the corner radius
               profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2.0
               profilePicture.clipsToBounds = true // This is necessary to clip the content within the rounded corners
        
        // Apply the corner radius
                userTextField.layer.cornerRadius = 25
                mobileTextField.layer.cornerRadius = 25
                intrestTextField.layer.cornerRadius = 25
                
        // Apply gradient text color to text fields
        userTextField.applyGradientTextColor(gradientObject: gradientObject)
        mobileTextField.applyGradientTextColor(gradientObject: gradientObject)
        intrestTextField.applyGradientTextColor(gradientObject: gradientObject)
        birthdayTextField.applyGradientTextColor(gradientObject: gradientObject)
        CampusTextField.applyGradientTextColor(gradientObject: gradientObject)
        SelectGender.applyGradientTextColor(gradientObject: gradientObject)
        FromAge.applyGradientTextColor(gradientObject: gradientObject)
        ToAge.applyGradientTextColor(gradientObject: gradientObject)
        
        // Apply gradient border color to text fields
        userTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        mobileTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        intrestTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        birthdayTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        CampusTextField.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())
        SelectGender.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: UIEdgeInsets())

        // Apply gradient text color to label
        TitleLabel.applyGradientTextColor(gradientObject: gradientObject)
               
        // Apply gradient text color to text view
        aboutTextView.applyGradientTextColor(gradientObject: gradientObject)
        
        let padding = UIEdgeInsets(top: 10, left: 10,bottom: 10, right: 10)
        aboutTextView.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: padding)
        

            }
    
    
    
}
