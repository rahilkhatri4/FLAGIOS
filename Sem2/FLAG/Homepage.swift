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
    
    @IBOutlet weak var LogoutButton: UIButton!
    
    @IBOutlet weak var dislikeButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        // Add any additional logout logic you may need (e.g., clearing user data, resetting states, etc.)
        
           // Navigate to the login page
           if let loginPageController = storyboard?.instantiateViewController(withIdentifier: "LoginViewpage") as? LoginpageController {
               navigationController?.pushViewController(loginPageController, animated: true)
           }
    }
    
    var users: [[String: Any]] = []
    var currentUserIndex: Int = 0
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            let futureView = UIView()
            Customstyles.applyDefaultStyle(to: futureView)
          
        
        fetchUsers()
        displayCurrentUser()
    
        
        }
    
    
    func fetchUsers() {
                if let ID = getUserID() {
                    // Construct the URL with the user ID
                    guard let url = URL(string: "https://e-invite.site/getUsers.php?id=\(ID)") else {
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
                            self.users = usersArray

                            DispatchQueue.main.async {
                                self.displayCurrentUser()
                            }
                        }
                    }
                }
                
            }.resume()
        } else {
            print("User ID not found")
        }
        
        }
    
    func displayCurrentUser() {
            guard currentUserIndex < users.count else {
                print("No more users to display")
                return
            }

            let currentUser = users[currentUserIndex]
            // Update your UI with details from the currentUser dictionary
            usernameLabel.text = currentUser["name"] as? String
            aboutLabel.text = currentUser["bio"] as? String
            campusLabel.text = currentUser["campus"] as? String
        
            currentUserIndex += 1
        }
    
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
            // Perform actions on dislike (e.g., send feedback, log action, etc.)
            print("User Disliked")
            
            // Move on to the next user
            displayCurrentUser()
        }

        @IBAction func likeButtonTapped(_ sender: UIButton) {
            // Perform actions on like (e.g., send feedback, log action, etc.)
            print("User Liked")

            // Move on to the next user
            displayCurrentUser()
        }
    
        func getUserID() -> Int? {
            return UserDefaults.standard.integer(forKey: "ID")
        }
    }

