import UIKit

class ConnectionspageController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var studentIdLabel: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var GobackButton: UIButton!
    
    //    @IBAction func didTapButton(){
//        if let homepageViewController = UIStoryboard(name: "Main", bundle: nil)
//               .instantiateViewController(withIdentifier: "HomepageController") as? HomepageController {
//               navigationController?.pushViewController(homepageViewController, animated: true)
//           }
//    }
    
    @IBAction func gobackButtonTapped(_ sender: UIButton) {
            // Navigate back to the previous view controller
            navigationController?.popViewController(animated: true)
        }
    
    @IBAction func notificationButtonTapped(_ sender: UIButton) {
        // Navigate to the NotificationViewController
        // Navigate to the NotificationViewController
        
        
        // Instantiate the NotificationViewController using the correct identifier
        if let notificationController = storyboard?.instantiateViewController(withIdentifier: "NotificationViewpage") as? NotificationViewController {
            navigationController?.pushViewController(notificationController, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                       let usersArray = jsonDictionary["users"] as? [[String: Any]] {
                        
                        // Update the UI on the main thread
                        DispatchQueue.main.async {
                            self.displayUsers(usersArray)
                        }
                    }
                }
            }
        }.resume()
    }
    
    func displayUsers(_ jsonArray: [[String: Any]]) {
        // Clear existing subviews
//        for subview in gradientView.subviews {
//            subview.removeFromSuperview()
//        }

        // Iterate through the array of users and add labels to display user information
        var yOffset: CGFloat = 200.0
        for user in jsonArray {
            let name = user["name"]!
           let birthdate = user["birthdate"]!
            print(name)
            print(birthdate)
//            let userLabel = UILabel()
//            userLabel.text = "Name: \(name), Birthdate: \(birthdate)"
//            userLabel.frame = CGRect(x: 20, y: yOffset, width: 300, height: 30)
//            gradientView.addSubview(userLabel)
//            yOffset += 40.0 // Adjust the vertical spacing
        }
    }
   
}


