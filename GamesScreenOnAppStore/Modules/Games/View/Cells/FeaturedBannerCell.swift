import UIKit

class FeaturedBannerCell: UICollectionViewCell {
    static let identifier = "FeaturedBannerCell"
    private var topStackView: UIStackView?
    private var bottomBannerStack: UIStackView?

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let availableLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let bannerImageView: UIImageView = {
        let  imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.layer.cornerRadius = 12
         imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
        return  imageView
    }()

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFit
         imageView.layer.cornerRadius = 10
         imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
         imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return  imageView
    }()

    private let appTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()

    private let appSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .label
        return label
    }()

    private let getButtonStack: UIStackView = {
        let getButton = UIButton(type: .system)
        getButton.setTitle("Get", for: .normal)
        getButton.setTitleColor(.white, for: .normal)
        getButton.backgroundColor = .lightGray
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        getButton.layer.cornerRadius = 14
        getButton.translatesAutoresizingMaskIntoConstraints = false
        getButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        getButton.heightAnchor.constraint(equalToConstant: 28).isActive = true

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .label
        label.text = "In-App Purchases"
        label.textAlignment = .center

        let rightStakView = UIStackView(arrangedSubviews: [getButton, label])
        rightStakView.axis = .vertical
        rightStakView.spacing = 2
        rightStakView.alignment = .center
        rightStakView.translatesAutoresizingMaskIntoConstraints = false
        return rightStakView
    }()

    
    
    
    private let bannerOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let appInfoStack: UIStackView = {
        let titleSubtitleStack = UIStackView()
        titleSubtitleStack.axis = .vertical
        titleSubtitleStack.spacing = 2

        let leftStakView = UIStackView()
        leftStakView.axis = .horizontal
        leftStakView.spacing = 8
        leftStakView.alignment = .center
        leftStakView.translatesAutoresizingMaskIntoConstraints = false
        leftStakView.addArrangedSubview(titleSubtitleStack)
        return leftStakView
    }()
    
    
    private func applyShadow(to View: UIView) {
        View.layer.shadowColor = UIColor.white.cgColor
        View.layer.shadowOpacity = 0.4
        View.layer.shadowRadius = 8
        View.layer.shadowOffset = CGSize(width: 0, height: 0)
        View.layer.masksToBounds = false

    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewHierarchy()
        applyShadow(to: bannerOverlayView)
        setupConstraints()
    }

    private func setupViewHierarchy() {
        contentView.addSubview(containerView)
        
        let topStackView = makeTopStackView()
        let bottomBannerStack = makeBottomBannerStack()
        
        containerView.addSubview(topStackView)
        containerView.addSubview(bannerImageView)
        bannerImageView.addSubview(bannerOverlayView)
        bannerOverlayView.addSubview(bottomBannerStack)
        bannerOverlayView.addSubview(getButtonStack)
        
        self.topStackView = topStackView
        self.bottomBannerStack = bottomBannerStack
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
    
    
    private func makeTopStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [availableLabel, titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }

    private func makeBottomBannerStack() -> UIStackView {
        let labelsStakView = UIStackView(arrangedSubviews: [appTitleLabel, appSubtitleLabel])
        labelsStakView.axis = .vertical
        labelsStakView.spacing = 2

        let logoStakView = UIStackView(arrangedSubviews: [logoImageView, labelsStakView])
        logoStakView.axis = .horizontal
        logoStakView.alignment = .center
        logoStakView.distribution = .equalSpacing
        logoStakView.spacing = 6
        logoStakView.translatesAutoresizingMaskIntoConstraints = false
        return logoStakView
    }


    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

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





