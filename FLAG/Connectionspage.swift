import UIKit

class ConnectionspageController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var studentIdLabel: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the content mode to aspect fit (or any other mode you prefer)
        profilePicture.contentMode = .scaleToFill
        
        // Add the rounded border by setting the corner radius
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2.0
        profilePicture.clipsToBounds = true // This is necessary to clip the content within the rounded corners
        
        // Apply gradient text color to text fields
        usernameLabel.applyGradientTextColor(gradientObject: gradientObject)
        
        studentIdLabel.applyGradientTextColor(gradientObject: gradientObject)
        
        // Set the font size for usernameLabel
        usernameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        fetchUsers()
    }
    
    func fetchUsers() {
        guard let url = URL(string: "https://chipcrop.xyz/getUsers.php") else {
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
