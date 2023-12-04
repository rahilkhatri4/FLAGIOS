import UIKit

class ConnectionspageController: UIViewController, UITableViewDataSource, UITableViewDelegate{
            
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var notificationButton: UIButton!
    
    @IBOutlet weak var GobackButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [[String: Any]] = []
    
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
        print("ViewDidLoad is called")
        
        tableView.dataSource = self
        tableView.delegate = self

        
        fetchUsers()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getUserID() -> Int? {
        return UserDefaults.standard.integer(forKey: "ID")
    }
    
    func fetchUsers() {
        if let ID = getUserID() {
            // Construct the URL with the user ID
            guard let url = URL(string: "https://e-invite.site/getMatches.php?id=\(ID)") else {
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
                           let usersArray = jsonDictionary["matches"] as? [[String: Any]] {
                            
                            // Update the UI on the main thread
                            DispatchQueue.main.async {
                                self.displayUsers(usersArray)
                            }
                        }
                    }
                }
            }.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("table view populate")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "matches", for: indexPath) as? UserTableViewCell else {
            fatalError("Unable to dequeue a cell with identifier matches as UserTableViewCell")
        }

        // Configure the cell with data from the 'users' array
        let user = users[indexPath.row]
        print("User at indexPath \(indexPath.row): \(user)")
        
        // Check if labels are nil
        print("Username label: \(cell.usernameLabel), Student ID label: \(cell.studentIdLabel)")

        cell.usernameLabel.text = user["name"] as? String
        cell.studentIdLabel.text = user["id"] as? String
        // Add more configurations as needed

        return cell
    }


    
    func displayUsers(_ jsonArray: [[String: Any]]) {
            print("display users")
            // Assuming each element in the 'users' array corresponds to a table view cell
            users = jsonArray

            // Reload the table view data on the main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }


