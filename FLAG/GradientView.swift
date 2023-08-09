//
//  GradientText.swift
//  FLAG
//
//  Created by VAMSI KATABATHUNI on 2023-07-25.
//

import Foundation
import UIKit

//Gradient styles:
//UITextField
//UITextLable

struct GradientObject {
    let colors: [UIColor]
    let startPoint: CGPoint
    let endPoint: CGPoint
}

// Example usage:
let gradientObject = GradientObject(colors: [
    UIColor(red: 32/255.0, green: 143/255.0, blue: 159/255.0, alpha: 1),
    UIColor(red: 31/255.0, green: 145/255.0, blue: 154/255.0, alpha: 1),
    UIColor(red: 43/255.0, green: 162/255.0, blue: 127/255.0, alpha: 1)
], startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 1, y: 0.5))

extension UITextField {
    func applyGradientTextColor(gradientObject: GradientObject, cornerRadius: CGFloat? = nil) {
        let text = self.text ?? ""
        let attributedText = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: attributedText.length)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = gradientObject.colors.map { $0.cgColor }
        gradientLayer.startPoint = gradientObject.startPoint
        gradientLayer.endPoint = gradientObject.endPoint
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        gradientLayer.render(in: context!)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.translateBy(x: 0.0, y: -self.bounds.size.height)
        let textPath = CGPath(rect: self.bounds, transform: nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(attributedText)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attributedText.length), textPath, nil)
        CTFrameDraw(frame, context!)
        context?.restoreGState()
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.textColor = UIColor(patternImage: gradientImage!)
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    func applyGradientBorderColor(gradientObject: GradientObject, cornerRadius: CGFloat, padding: UIEdgeInsets) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = gradientObject.colors.map { $0.cgColor }
            gradientLayer.startPoint = gradientObject.startPoint
            gradientLayer.endPoint = gradientObject.endPoint

            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            gradientLayer.render(in: context!)
            context?.scaleBy(x: 1.0, y: -1.0)
            context?.translateBy(x: 0.0, y: -self.bounds.size.height)
            let borderPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
            borderPath.lineWidth = 1.0
            borderPath.addClip()
            gradientObject.colors.last?.setStroke()
            borderPath.stroke()
            context?.restoreGState()
            let gradientBorderImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor(patternImage: gradientBorderImage!).cgColor
            self.layer.cornerRadius = cornerRadius
            
        }
    
}

extension UILabel {
    func applyGradientTextColor(gradientObject: GradientObject) {
        let text = self.text ?? ""
        let attributedText = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: attributedText.length)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = gradientObject.colors.map { $0.cgColor }
        gradientLayer.startPoint = gradientObject.startPoint
        gradientLayer.endPoint = gradientObject.endPoint
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        gradientLayer.render(in: context!)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.translateBy(x: 0.0, y: -self.bounds.size.height)
        let textPath = CGPath(rect: self.bounds, transform: nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(attributedText)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attributedText.length), textPath, nil)
        CTFrameDraw(frame, context!)
        context?.restoreGState()
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.textColor = UIColor(patternImage: gradientImage!)
    }
}

extension UITextView {
    func applyGradientTextColor(gradientObject: GradientObject) {
        let text = self.text ?? ""
        let attributedText = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: attributedText.length)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = gradientObject.colors.map { $0.cgColor }
        gradientLayer.startPoint = gradientObject.startPoint
        gradientLayer.endPoint = gradientObject.endPoint
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        gradientLayer.render(in: context!)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.translateBy(x: 0.0, y: -self.bounds.size.height)
        let textPath = CGPath(rect: self.bounds, transform: nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(attributedText)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attributedText.length), textPath, nil)
        CTFrameDraw(frame, context!)
        context?.restoreGState()
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.textColor = UIColor(patternImage: gradientImage!)
    }
    
    func applyGradientBorderColor(gradientObject: GradientObject, cornerRadius: CGFloat, padding: UIEdgeInsets) {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = gradientObject.colors.map { $0.cgColor }
            gradientLayer.startPoint = gradientObject.startPoint
            gradientLayer.endPoint = gradientObject.endPoint

            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            gradientLayer.render(in: context!)
            context?.scaleBy(x: 1.0, y: -1.0)
            context?.translateBy(x: 0.0, y: -self.bounds.size.height)
            let borderPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
            borderPath.lineWidth = 1.0
            borderPath.addClip()
            gradientObject.colors.last?.setStroke()
            borderPath.stroke()
            context?.restoreGState()
            let gradientBorderImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor(patternImage: gradientBorderImage!).cgColor
            self.layer.cornerRadius = cornerRadius
            
            // Add padding using textContainerInset
            self.textContainerInset = padding
        }

}


extension UIButton {
    func applyGradientBackgroundColor(gradientObject: GradientObject, cornerRadius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = gradientObject.colors.map { $0.cgColor }
        gradientLayer.startPoint = gradientObject.startPoint
        gradientLayer.endPoint = gradientObject.endPoint

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        gradientLayer.mask = shapeLayer

        layer.insertSublayer(gradientLayer, at: 0)

        layer.cornerRadius = cornerRadius
    }
}

// New custom GradientTextField
class GradientTextField: UITextField {
    private let gradientLayer = CAGradientLayer()

    var gradientColors: [UIColor] = [] {
        didSet {
            updateGradient()
        }
    }

    var startPoint: CGPoint = CGPoint(x: 0, y: 0.5) {
        didSet {
            updateGradient()
        }
    }

    var endPoint: CGPoint = CGPoint(x: 1, y: 0.5) {
        didSet {
            updateGradient()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradient()
    }

    private func updateGradient() {
        gradientLayer.frame = CGRect(x: 0, y: bounds.size.height - 2, width: bounds.size.width, height: 2)
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        // Remove any existing gradient layer before adding a new one
        if let existingLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            existingLayer.removeFromSuperlayer()
        }

        layer.addSublayer(gradientLayer)
    }
}

extension UIButton {
    func applyGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0.11, green: 0.55, blue: 0.64, alpha: 1.00).cgColor, UIColor(red: 0.18, green: 0.64, blue: 0.47, alpha: 1.00).cgColor]
        gradientLayer.cornerRadius = 10
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
}

