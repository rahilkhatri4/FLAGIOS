//
//  Signuppage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-27.
//

import Foundation
import UIKit

class SignuppageController: UIViewController {
    
    @IBOutlet weak var lastnameTextField: GradientTextField!
    
    @IBOutlet weak var firstnameTextField: GradientTextField!
    
    @IBOutlet weak var emailidTextField: GradientTextField!
    
    @IBOutlet weak var passwordTextField: GradientTextField!
    
    @IBOutlet weak var confirmpasswordTextField: GradientTextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        signupButton.applyGradient()
            }

            func setupTextFields() {
                let gradientObject = GradientObject(colors: [
                    UIColor(red: 32/255.0, green: 143/255.0, blue: 159/255.0, alpha: 1),
                    UIColor(red: 31/255.0, green: 145/255.0, blue: 154/255.0, alpha: 1),
                    UIColor(red: 43/255.0, green: 162/255.0, blue: 127/255.0, alpha: 1)
                ], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))

                let textFields: [GradientTextField] = [
                    lastnameTextField,
                    firstnameTextField,
                    emailidTextField,
                    passwordTextField,
                    confirmpasswordTextField
                ]

                textFields.forEach { textField in
                    textField.applyGradientTextColor(gradientObject: gradientObject)
                    textField.gradientColors = gradientObject.colors
                    textField.startPoint = gradientObject.startPoint
                    textField.endPoint = gradientObject.endPoint

                    let leftPadding: CGFloat = 35.0
                    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 1))
                    textField.leftView = paddingView
                    textField.leftViewMode = .always
                }
            }
        }
