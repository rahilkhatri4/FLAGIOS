//
//  StyleSheet.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-25.
//

import Foundation
import UIKit

class Customstyles {
    
    static func applyDefaultTextFieldStyle(to textField: UITextField) {
        textField.textColor = .white
        // You can add more styling for the text field here if needed
    }
    
    static func applyDefaultStyle(to view: UIView) {
        let gradientLayer = CAGradientLayer()
                gradientLayer.frame = view.bounds
                gradientLayer.colors = [
                    UIColor(red: 32/255, green: 143/255, blue: 159/255, alpha: 1).cgColor,
                    UIColor(red: 31/255, green: 145/255, blue: 154/255, alpha: 1).cgColor,
                    UIColor(red: 43/255, green: 162/255, blue: 127/255, alpha: 1).cgColor
                ]
                gradientLayer.locations = [0.12, 0.26, 0.84]
                gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

               

                view.layer.insertSublayer(gradientLayer, at: 0)
        
                view.layer.cornerRadius = 25
    }
    
    func applyTextFieldStyle(textField: GradientTextField, gradientObject: GradientObject) {
            // Set the gradient colors for the text field
            textField.gradientColors = gradientObject.colors
            textField.startPoint = gradientObject.startPoint
            textField.endPoint = gradientObject.endPoint

            // Add left padding to the text field
            let leftPadding: CGFloat = 25.0
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 1))
            textField.leftView = paddingView
            textField.leftViewMode = .always
        }
    
    static func applyGradientStyle(to textField: GradientTextField, gradientObject: GradientObject) {
            textField.applyGradientTextColor(gradientObject: gradientObject)
            textField.gradientColors = gradientObject.colors
            textField.startPoint = gradientObject.startPoint
            textField.endPoint = gradientObject.endPoint
        }
        
        static func applyLeftPadding(to textField: UITextField, padding: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 1))
            textField.leftView = paddingView
            textField.leftViewMode = .always
        }
   
}
