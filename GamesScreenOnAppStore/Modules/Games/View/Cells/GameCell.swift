
import UIKit

// MARK: - GameCell

class GameCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "GameCell"
    
    // MARK: - UI Components

    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var gameSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .systemBlue
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
        config.imagePadding = 4

        let button = UIButton(type: .system)
        button.configuration = config
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .vertical)
        return button
    }()
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods

    private func setupViews() {
        let labelsStackView = UIStackView(arrangedSubviews: [gameLabel, gameSubtitleLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        
        let itemStackView = UIStackView(arrangedSubviews: [gameImageView, labelsStackView, actionButton])
        itemStackView.alignment = .center
        itemStackView.spacing = 12
        itemStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(itemStackView)
        
        NSLayoutConstraint.activate([
            gameImageView.widthAnchor.constraint(equalToConstant: 60),
            gameImageView.heightAnchor.constraint(equalToConstant: 60),
            itemStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            itemStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    // MARK: - Configuration

    func configure(with game: Game) {
        gameLabel.text = game.title
        gameSubtitleLabel.text = game.subtitle
        gameImageView.image = UIImage(named: game.imageName)
        configureActionButton(for: game)
    }

    private func configureActionButton(for game: Game) {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .systemBlue
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
        config.imagePadding = 4

        if game.isInstalled {
            config.title = "Open"
            config.baseBackgroundColor = .systemGray5
        } else if game.downloaded {
            config.title = nil
            config.baseBackgroundColor = .systemGroupedBackground
            config.image = resizeImage(named: "download", to: CGSize(width: 30, height: 30))
        } else {
            config.title = "Get"
            config.baseBackgroundColor = .systemGray5
        }

        actionButton.configuration = config
    }

    // MARK: - Helpers

    private func resizeImage(named name: String, to size: CGSize) -> UIImage? {
        guard let image = UIImage(named: name) else { return nil }
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

