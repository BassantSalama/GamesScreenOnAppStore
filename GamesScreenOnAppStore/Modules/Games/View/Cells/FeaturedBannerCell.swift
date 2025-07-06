import UIKit

// MARK: - FeaturedBannerCell

class FeaturedBannerCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "FeaturedBannerCell"
    
    // MARK: - UI Properties
    
    private var topStackView: UIStackView?
    private var bottomBannerStack: UIStackView?

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let availableLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bannerOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()

    private let appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()

    private let appSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        return label
    }()

    private let getButtonStack: UIStackView = {
        let getButton = UIButton(type: .system)
        getButton.setTitle("Get", for: .normal)
        getButton.setTitleColor(.white, for: .normal)
        getButton.backgroundColor = .lightGray
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        getButton.layer.cornerRadius = 14
        getButton.translatesAutoresizingMaskIntoConstraints = false
        getButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        getButton.heightAnchor.constraint(equalToConstant: 28).isActive = true

        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .label
        label.text = "In-App Purchases"
        label.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [getButton, label])
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        applyShadow(to: bannerOverlayView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup Methods

    private func setupViewHierarchy() {
        contentView.addSubview(containerView)
        
        let topStack = makeTopStackView()
        let bottomStack = makeBottomBannerStack()

        containerView.addSubview(topStack)
        containerView.addSubview(bannerImageView)
        bannerImageView.addSubview(bannerOverlayView)
        bannerOverlayView.addSubview(bottomStack)
        bannerOverlayView.addSubview(getButtonStack)

        self.topStackView = topStack
        self.bottomBannerStack = bottomStack
    }

    private func setupConstraints() {
        guard let topStackView = topStackView,
              let bottomBannerStack = bottomBannerStack else { return }

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            topStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            topStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),

            bannerImageView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            bannerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 190),
            bannerImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

            bannerOverlayView.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor),
            bannerOverlayView.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor),
            bannerOverlayView.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor),

            bottomBannerStack.leadingAnchor.constraint(equalTo: bannerOverlayView.leadingAnchor, constant: 12),
            bottomBannerStack.topAnchor.constraint(equalTo: bannerOverlayView.topAnchor),
            bottomBannerStack.bottomAnchor.constraint(equalTo: bannerOverlayView.bottomAnchor, constant: -12),

            getButtonStack.topAnchor.constraint(equalTo: bannerOverlayView.topAnchor),
            getButtonStack.bottomAnchor.constraint(equalTo: bannerOverlayView.bottomAnchor, constant: -12),
            getButtonStack.trailingAnchor.constraint(equalTo: bannerOverlayView.trailingAnchor, constant: -12)
        ])
    }

    private func applyShadow(to view: UIView) {
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = .zero
        view.layer.masksToBounds = false
    }

    // MARK: - Factory Methods

    private func makeTopStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [availableLabel, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func makeBottomBannerStack() -> UIStackView {
        let labelsStack = UIStackView(arrangedSubviews: [appTitleLabel, appSubtitleLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 2

        let logoStack = UIStackView(arrangedSubviews: [logoImageView, labelsStack])
        logoStack.axis = .horizontal
        logoStack.alignment = .center
        logoStack.spacing = 6
        logoStack.translatesAutoresizingMaskIntoConstraints = false
        return logoStack
    }

    // MARK: - Configuration

    func configure(with game: FeaturedGame) {
        bannerImageView.image = game.bannerImage
        logoImageView.image = game.iconImage
        availableLabel.text = "NOW AVAILABLE"
        titleLabel.text = game.title
        descriptionLabel.text = game.description
        appTitleLabel.text = game.title
        appSubtitleLabel.text = "Lead Your Clan to Victory!"
    }
}




