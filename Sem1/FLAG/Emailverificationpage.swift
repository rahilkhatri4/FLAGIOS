//
//  Emailverificationpage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-27.
//

import Foundation

import Foundation
import UIKit

class Emailverificationpage: UIViewController {
    
    @IBOutlet weak var emailidTextField: GradientTextField!
    
    @IBOutlet weak var verifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyButton.applyGradient()
        
        
        // Apply gradient text color to text fields
        emailidTextField.applyGradientTextColor(gradientObject: gradientObject)
        
        // Set the gradient colors for the usernameTextField
        emailidTextField.gradientColors = gradientObject.colors
        emailidTextField.startPoint = gradientObject.startPoint
        emailidTextField.endPoint = gradientObject.endPoint
        
        let leftPadding: CGFloat = 35.0

        let emailidPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 1))
        emailidTextField.leftView = emailidPaddingView
        emailidTextField.leftViewMode = .always
        
        // Attach the action to the verifyButton
                verifyButton.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)

    }
    
    @objc func verifyButtonTapped() {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let emailVerificationPage = storyboard.instantiateViewController(withIdentifier: "OTPverificationpage") as! OTPverificationpage
                self.present(emailVerificationPage, animated: true, completion: nil)
            }
        }
    
}
