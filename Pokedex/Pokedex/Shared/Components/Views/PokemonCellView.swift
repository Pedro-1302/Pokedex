//
//  PokemonCellView.swift
//  Pokedex
//
//  Created by Pedro Franco on 31/05/25.
//

import UIKit
import Kingfisher

final class PokemonCellView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private let imagePadding: CGFloat = 16
    private let imagaSize: CGFloat = 120

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ pokemon: Pokemon) {
        loadImage(from: pokemon.imageUrl)
    }
}

// MARK: - Private Methods
extension PokemonCellView {
    private func setupLayout() {
        setupContainerView()
        setupImageView()
    }

    private func setupContainerView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupImageView() {
        containerView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: imagePadding),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: imagePadding),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -imagePadding),
            imageView.widthAnchor.constraint(equalToConstant: imagaSize),
            imageView.heightAnchor.constraint(equalToConstant: imagaSize)
        ])
    }

    private func loadImage(from urlString: String) {
        if let url = URL(string: urlString) {
            let shimmer = ShimmerView(frame: imageView.bounds)
            imageView.kf.setImage(
                with: url,
                placeholder: shimmer,
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ],
                completionHandler: { result in
                    shimmer.stopShimmer()
                    switch result {
                    case .success(let value):
                        logger.debug("Image loaded: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        logger.error("Failed to load image: \(error)")
                    }
                }
            )
        } else {
            logger.error("Error loading image URL. Attempt to use placeholder image.")
            imageView.image = UIImage(named: "placeholder")
        }
    }
}
