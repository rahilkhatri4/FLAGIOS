//
//  Loginpage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-26.
//

import Foundation
import UIKit

class LoginpageController: UIViewController {

    
    @IBOutlet weak var usernameTextField: GradientTextField!
    
    @IBOutlet weak var passwordTextField: GradientTextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var createaccountLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

                let gradientObject = GradientObject(colors: [
                    UIColor(red: 32/255.0, green: 143/255.0, blue: 159/255.0, alpha: 1),
                    UIColor(red: 31/255.0, green: 145/255.0, blue: 154/255.0, alpha: 1),
                    UIColor(red: 43/255.0, green: 162/255.0, blue: 127/255.0, alpha: 1)
                ], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))

                // Apply gradient style to text fields
        Customstyles.applyGradientStyle(to: usernameTextField, gradientObject: gradientObject)
        Customstyles.applyGradientStyle(to: passwordTextField, gradientObject: gradientObject)

                // Add left padding to text fields
                let leftPadding: CGFloat = 35.0
        Customstyles.applyLeftPadding(to: usernameTextField, padding: leftPadding)
        Customstyles.applyLeftPadding(to: passwordTextField, padding: leftPadding)
        
        
                loginButton.applyGradient()
        
                // Apply gradient text color to label
                createaccountLabel.applyGradientTextColor(gradientObject: gradientObject)
            }
    
    func makeLoginRequest(email: String, password: String) {
        guard let url = URL(string: "https://e-invite.site/login.php") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the content type header for form data
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let postString = "email=\(email)&password=\(password)"
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
                                print("Login Successful")
                                self.navigateToHomepage()
                            } else {
                                if let error = jsonResponse["error"] as? String {
                                    print("Login Failed: \(error)")
                                    // Handle login failure, show error message to user
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




    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if let email = usernameTextField.text, let password = passwordTextField.text {
            makeLoginRequest(email: email, password: password)
        }
    
    }
    
    func navigateToHomepage() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "MaintabViewController") as! UITabBarController
            UIApplication.shared.windows.first?.rootViewController = tabBarController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
       
    @IBAction func createAccountLabelTapped(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let signupVC = storyboard.instantiateViewController(withIdentifier: "SignuppageController") as! SignuppageController
           present(signupVC, animated: true, completion: nil)
    }
        }
