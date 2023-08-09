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
    
    func makeSignupRequest(firstName: String, lastName: String, email: String, password: String, confirmPassword: String) {
        
        let name = firstName + " " + lastName;
            guard let url = URL(string: "https://chipcrop.xyz/registerUser.php") else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Set the content type header for form data
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            let postString = "register=register&name=\(name)&email=\(email)&password=\(password)&confirmpassword=\(confirmPassword)"
            request.httpBody = postString.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // Process and print the JSON response
                            print("JSON Response: \(jsonResponse)")
                            
                            // Check if 'success' key exists in the response
                            if let success = jsonResponse["success"] as? Bool {
                                if success {
                                    print("Signup Successful")
                                    // Perform actions for successful signup
                                } else {
                                    if let error = jsonResponse["error"] as? String {
                                        print("Signup Failed: \(error)")
                                        // Handle signup failure, show error message to user
                                    }
                                }
                            }
                        }
                    } catch let error {
                        print("Error decoding response: \(error.localizedDescription)")
                    }
                }
            }
            
            task.resume()
        }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
            if let firstName = firstnameTextField.text,
               let lastName = lastnameTextField.text,
               let email = emailidTextField.text,
               let confirmPassword = confirmpasswordTextField.text,
               let password = passwordTextField.text {
                makeSignupRequest(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword)
            }
        }
    }
