//
//  OTPverificationpage.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-27.
//

import Foundation

import Foundation
import UIKit

class OTPverificationpage: UIViewController {
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UITextView!
    
    @IBOutlet weak var box1Label: UILabel!
    
    @IBOutlet weak var box2Label: UILabel!
    
    @IBOutlet weak var box3Label: UILabel!
    
    @IBOutlet weak var box4Label: UILabel!
    
    @IBOutlet weak var verifyButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                setupLabels()
                verifyButton.applyGradient()
        
        // Attach the action to the verifyButton
                verifyButton.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)
        
            }

            func setupLabels() {
                let gradientObject = GradientObject(colors: [
                    UIColor(red: 32/255.0, green: 143/255.0, blue: 159/255.0, alpha: 1),
                    UIColor(red: 31/255.0, green: 145/255.0, blue: 154/255.0, alpha: 1),
                    UIColor(red: 43/255.0, green: 162/255.0, blue: 127/255.0, alpha: 1)
                ], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))

                let labels: [UILabel] = [
                    TitleLabel,
                    box1Label,
                    box2Label,
                    box3Label,
                    box4Label
                ]

                labels.forEach { label in
                    label.applyGradientTextColor(gradientObject: gradientObject)
                    label.layer.cornerRadius = 10.0
                    label.layer.masksToBounds = true
                }
            }
    
    @objc func verifyButtonTapped() {
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let otpVerificationPage = storyboard.instantiateViewController(withIdentifier: "LoginpageController") as! LoginpageController
                self.present(otpVerificationPage, animated: true, completion: nil)
            }
        }
        }
