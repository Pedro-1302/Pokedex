import UIKit

final class PokemonHeaderView: UIStackView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 96),
            imageView.heightAnchor.constraint(equalToConstant: 96)
        ])
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()

    private let dexIdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        return label
    }()

    private let typesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fill
        view.alignment = .leading
        return view
    }()

    private let infoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        return view
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: PokemonHeaderInfo) {
        nameLabel.text = model.name
        dexIdLabel.text = model.dexId.getPokemonDexId()
        imageView.setImage(from: model.imageURL)
        show(types: model.types)
    }
}

// MARK: - Private Methods
extension PokemonHeaderView {
    private func setupView() {
        configureStackView()
        addSubviews()
    }

    private func configureStackView() {
        axis = .horizontal
        spacing = 16
        alignment = .center
        layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        isLayoutMarginsRelativeArrangement = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func addSubviews() {
        infoStackView.addArrangedSubview(dexIdLabel)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(typesStackView)
        addArrangedSubview(imageView)
        addArrangedSubview(infoStackView)
    }

    private func show(types: [PokemonTypeName]) {
        typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let verticalStack = createNewLineVerticalStackView()
        typesStackView.addArrangedSubview(verticalStack)
        let maxWidth = UIScreen.main.bounds.width - 32
        var currentLineStack = createNewLineHorizontalStackView()
        verticalStack.addArrangedSubview(currentLineStack)
        var currentLineWidth: CGFloat = 0

        for type in types {
            let typeView = UIView()
            typeView.backgroundColor = type.color
            typeView.layer.cornerRadius = 4
            typeView.translatesAutoresizingMaskIntoConstraints = false

            let label = UILabel()
            label.text = type.displayName
            label.textColor = .white
            label.font = .systemFont(ofSize: 14, weight: .bold)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false

            typeView.addSubview(label)
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: typeView.topAnchor, constant: 4),
                label.bottomAnchor.constraint(equalTo: typeView.bottomAnchor, constant: -4),
                label.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 8),
                label.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -8)
            ])

            let labelSize = label.intrinsicContentSize
            let typeViewWidth = labelSize.width + 16

            if currentLineWidth + typeViewWidth + (currentLineWidth > 0 ? 8 : 0) > maxWidth {
                currentLineStack = createNewLineHorizontalStackView()
                verticalStack.addArrangedSubview(currentLineStack)
                currentLineWidth = 0
            }

            currentLineStack.addArrangedSubview(typeView)
            typeView.widthAnchor.constraint(equalToConstant: typeViewWidth).isActive = true
            currentLineWidth += typeViewWidth + (currentLineWidth > 0 ? 8 : 0)
        }
    }

    private func createNewLineHorizontalStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }

    private func createNewLineVerticalStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
