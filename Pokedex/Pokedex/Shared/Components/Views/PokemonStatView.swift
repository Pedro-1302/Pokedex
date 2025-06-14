import UIKit

final class PokemonStatView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return label
    }()

    private let baseStatLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .clear
        progressView.progressTintColor = .systemGreen
        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()

    private let maxStatLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(title: String, maxValue: String) {
        super.init(frame: .zero)
        configureStackView()
        setTitleLabelText(title)
        setMaxStatLabelText(maxValue)
        addSubviewsToStackView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateStat(baseValue: Int, maxValue: Float, color: UIColor?) {
        baseStatLabel.text = "\(baseValue)"
        let progress = min(Float(baseValue) / maxValue, 1.0)
        progressView.setProgress(progress, animated: true)
        if let color = color {
            progressView.tintColor = color
        }
    }
}

// MARK: - Private Methods
extension PokemonStatView {
    private func configureStackView() {
        axis = .horizontal
        distribution = .fill
        alignment = .center
        spacing = 8
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setTitleLabelText(_ title: String) {
        titleLabel.text = title
    }

    private func setMaxStatLabelText(_ maxValue: String) {
        maxStatLabel.text = maxValue
    }

    private func addSubviewsToStackView() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(baseStatLabel)
        addArrangedSubview(progressView)
        addArrangedSubview(maxStatLabel)
    }
}
