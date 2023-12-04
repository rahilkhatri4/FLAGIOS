//
//  Homepage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-25.
//

import Foundation

import UIKit

class HomepageController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var campusLabel: UILabel!
    
    @IBOutlet weak var SendInterest: UIButton!
    
    @IBOutlet weak var NextProfile: UIButton!
    
    @IBOutlet weak var LogoutButton: UIButton!
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        // Add any additional logout logic you may need (e.g., clearing user data, resetting states, etc.)
        
           // Navigate to the login page
           if let loginPageController = storyboard?.instantiateViewController(withIdentifier: "LoginViewpage") as? LoginpageController {
               navigationController?.pushViewController(loginPageController, animated: true)
           }
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            let futureView = UIView()
            Customstyles.applyDefaultStyle(to: futureView)
          
        
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

