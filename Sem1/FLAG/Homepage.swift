//
//  Homepage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-25.
//

import Foundation

import UIKit

class HomepageController: UIViewController {

    @IBOutlet weak var basicView: UIView!
    
    @IBOutlet weak var interestView: UIView!
    
    @IBOutlet weak var basicTextField: UITextField!
    
    @IBOutlet weak var interestTextField: UITextField!
    
    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var SendInterest: UIButton!
    
    @IBOutlet weak var NextProfile: UIButton!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        
            // Set the corner radius for basicView and interestView
            Customstyles.applyDefaultStyle(to: basicView)
            Customstyles.applyDefaultStyle(to: interestView)
            
            // Apply custom styles to text fields
            Customstyles.applyDefaultTextFieldStyle(to: basicTextField)
            Customstyles.applyDefaultTextFieldStyle(to: interestTextField)
        
            // Apply gradient text color to text view
            aboutTextView.applyGradientTextColor(gradientObject: gradientObject)

        // Apply gradient border to text view
//            let padding = UIEdgeInsets(top: 10, left: 10,bottom: 10, right: 10)
//            aboutTextView.applyGradientBorderColor(gradientObject: gradientObject, cornerRadius: 10, padding: padding)
        
            // Example: Apply the same style to a futureView
            let futureView = UIView()
            Customstyles.applyDefaultStyle(to: futureView)
            // Add futureView to the view hierarchy
        
        basicView.layer.cornerRadius = 5;
        basicView.layer.masksToBounds = true;
        interestView.layer.cornerRadius = 5;
        interestView.layer.masksToBounds = true;
        
        fetchUsers()
    
        
        }
    
    
    func fetchUsers() {
            guard let url = URL(string: "https://e-invite.site/getUsers.php") else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        // Print the JSON response (encoded string)
                        print("JSON Response:\n\(jsonString)")
                        
                        // Parse the JSON-encoded string
                        if let jsonData = jsonString.data(using: .utf8),
                           let jsonDictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                           let success = jsonDictionary["success"] as? Bool, success,
                           let usersArray = jsonDictionary["users"] as? [[String: Any]] {
                            
                            // Update the UI on the main thread
//                            DispatchQueue.main.async {
//                                self.displayUsers(usersArray)
//                            }
                        }
                    }
                }
                
            }.resume()
        
        
        }
    
    
    
    
    }

