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
    
    @IBOutlet weak var customSearchBar: UISearchBar!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            // Set the corner radius for basicView and interestView
            Customstyles.applyDefaultStyle(to: basicView)
            Customstyles.applyDefaultStyle(to: interestView)
            
            // Apply custom styles to text fields
            Customstyles.applyDefaultTextFieldStyle(to: basicTextField)
            Customstyles.applyDefaultTextFieldStyle(to: interestTextField)

            // Example: Apply the same style to a futureView
            let futureView = UIView()
            Customstyles.applyDefaultStyle(to: futureView)
            // Add futureView to the view hierarchy
        
        basicView.layer.cornerRadius = 5;
        basicView.layer.masksToBounds = true;
        interestView.layer.cornerRadius = 5;
        interestView.layer.masksToBounds = true;
        
        }
    }
