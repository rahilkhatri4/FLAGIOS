//
//  Connectionspage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-25.
//

import Foundation
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
    }
}
