
import UIKit

class GameCell: UICollectionViewCell {
    static let identifier = "GameCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit

        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.textColor = .gray

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .systemBlue
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)

        actionButton.configuration = config
        actionButton.configurationUpdateHandler = { button in
            button.configuration?.imagePadding = 4
        }

        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 4

        let stack = UIStackView(arrangedSubviews: [imageView, labelsStack, actionButton])
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
        
        
        actionButton.setContentHuggingPriority(.required, for: .horizontal)
        actionButton.setContentHuggingPriority(.required, for: .vertical)
    }

    func configure(with game: Game) {
        titleLabel.text = game.title
        subtitleLabel.text = game.subtitle
        imageView.image = UIImage(named: game.imageName)
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .systemBlue
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)

        if game.isInstalled {
            config.title = "Open"
            config.image = nil
        } else if game.downloaded {
            config.title = nil
            config.baseBackgroundColor = .systemGroupedBackground
            config.image = UIImage(systemName: "square.and.arrow.down")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold))
        } else {
            config.title = "Get"
            config.image = nil
        }

        config.imagePadding = 4
        actionButton.configuration = config
    }
}
