import UIKit
import Kingfisher

final class ShimmerView: UIView, Placeholder {
    private let gradientLayer = CAGradientLayer()
    private let keyPath: String = "locations"
    private let animationKey: String = "shimmerAnimation"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit { cleanUp() }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        startAnimating()
    }

    func stopShimmer() { cleanUp() }
}

// MARK: - Private Methods
extension ShimmerView {
    private func setupGradient() {
        let light = UIColor(white: 0.85, alpha: 1).cgColor
        let dark = UIColor(white: 0.75, alpha: 1).cgColor
        gradientLayer.colors = [dark, light, dark]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0, 0.5, 1]
        layer.addSublayer(gradientLayer)
    }

    private func startAnimating() {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = [-1, -0.5, 0]
        animation.toValue = [1, 1.5, 2]
        animation.duration = 1.0
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: animationKey)
    }

    private func cleanUp() {
        gradientLayer.removeAnimation(forKey: animationKey)
        gradientLayer.removeFromSuperlayer()
    }
}
