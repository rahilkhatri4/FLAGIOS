import Foundation
import UIKit

class GradientButton: UIButton {
    private var gradientLayer: CAGradientLayer?

    func applyGradientBackground(gradientObject: GradientObject) {
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            layer.insertSublayer(gradientLayer!, at: 0)
        }
        gradientLayer?.colors = gradientObject.colors.map { $0.cgColor }
        gradientLayer?.startPoint = gradientObject.startPoint
        gradientLayer?.endPoint = gradientObject.endPoint
        gradientLayer?.frame = bounds

        UIGraphicsBeginImageContextWithOptions(gradientLayer!.bounds.size, false, 0.0)
        gradientLayer?.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        setBackgroundImage(gradientImage, for: .normal)
    }
}
