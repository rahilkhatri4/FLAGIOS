//
//  Homepage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-25.
//

import Foundation

import UIKit

class HomepageController: UIViewController {
    
    var currentID: String = ""
    
    var lastUserLiked: Bool = false
    
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
        if currentUserIndex < users.count {
            let currentUser = users[currentUserIndex]
            print(currentUser["id"]!)

            if let userID = currentUser["id"] as? String {
                currentID = userID
            }
            // Update your UI with details from the currentUser dictionary
            usernameLabel.text = currentUser["name"] as? String
            aboutLabel.text = currentUser["bio"] as? String
            campusLabel.text = currentUser["campus"] as? String

            // Show UI elements
            usernameLabel.isHidden = false
            aboutLabel.isHidden = false
            campusLabel.isHidden = false
        } else {
            // Display an alert if there are no more users
            let alertController = UIAlertController(title: "No More Users", message: "There are no more users to display.", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                // Perform any additional actions if needed
            }

            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            
            // No more users, hide UI elements
            usernameLabel.isHidden = true
            aboutLabel.isHidden = true
            campusLabel.isHidden = true
            
            return
        }
        
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

            // Check if there are more users
                if currentUserIndex < users.count
                {
                    
                } else {
                    if currentUserIndex == users.count && lastUserLiked == false {
                      lastUserLiked = true
                    } else {
                        // Display an alert if there are no more users
                        let alertController = UIAlertController(title: "No More Users", message: "There are no more users to like.", preferredStyle: .alert)

                        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                            // Perform any additional actions if needed
                        }

                        alertController.addAction(okAction)
                        present(alertController, animated: true, completion: nil)
                        return
                    }
                }
            
            guard let currentUserID = getUserID() else {
                    print("Current user ID not found")
                    return
                }
            
            // Construct the URL for the like action
                let likeUrlString = "https://e-invite.site/likeuser.php"
                guard let likeUrl = URL(string: likeUrlString) else {
                    print("Invalid like URL")
                    return
                }

                var request = URLRequest(url: likeUrl)
                request.httpMethod = "POST"
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

                // Create the POST string with the liked user's and current user's IDs
                let postString = "likeid=\(currentID)&likedbyid=\(currentUserID)"
                request.httpBody = postString.data(using: .utf8)

                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error liking user: \(error.localizedDescription)")
                        return
                    }

                    if let data = data {
                        if let dataString = String(data: data, encoding: .utf8) {
                            print("Like response:\n\(dataString)")

                            // Handle the like response as needed
                            // You might want to check for success or show an alert to the user
                        }
                    }
                }.resume()
            
            // Move on to the next user
            displayCurrentUser()
        }
    
        func getUserID() -> Int? {
            return UserDefaults.standard.integer(forKey: "ID")
        }
    }

