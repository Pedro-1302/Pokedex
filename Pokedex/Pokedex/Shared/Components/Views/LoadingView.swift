import UIKit

final class LoadingView: UIView {
    private let spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .systemRed
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func show(in view: UIView) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(self)
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.topAnchor),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }

    func hide() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.removeFromSuperview()
        }
    }
}

private extension LoadingView {
    func setupView() {
        backgroundColor = .secondarySystemBackground
        configureSpinner()
    }

    func configureSpinner() {
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        spinner.startAnimating()
    }
}
