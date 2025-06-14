import UIKit

final class PokemonCellView: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
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

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()

    private let dexIdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()

    private let imagePadding: CGFloat = 16
    private let imagaSize: CGFloat = 120
    private let stackViewPadding: CGFloat = 16

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        dexIdLabel.text = pokemon.id.getPokemonDexId()
        imageView.setImage(from: pokemon.imageUrl)
    }
}

// MARK: - Private Methods
extension PokemonCellView {
    private func setupLayout() {
        setupContainerView()
        setupImageView()
        setupVerticalStackView()
    }

    private func setupContainerView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
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

    private func setupVerticalStackView() {
        containerView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(dexIdLabel)
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: stackViewPadding),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                        constant: -stackViewPadding),
            verticalStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
