import UIKit

extension UIImageView {
    func setImage(from urlString: String, placeholderName: String = "placeholder") {
        guard let url = URL(string: urlString) else {
            logger.error("Invalid url: \(urlString). Using placeholder.")
            self.image = UIImage(named: placeholderName)
            return
        }

        let shimmer = ShimmerView(frame: self.bounds)
        self.kf.setImage(
            with: url,
            placeholder: shimmer,
            options: [
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ]
        ) { result in
            shimmer.stopShimmer()
            switch result {
            case .success(let value):
                logger.debug("Image loaded: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                logger.error("Failed to load image: \(error)")
            }
        }
    }
}
