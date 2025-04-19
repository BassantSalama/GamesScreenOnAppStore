
import UIKit

class EventCell: UICollectionViewCell {
    static let identifier = "EventCell"
    
    private let happeningNow: UILabel = {
        let label = UILabel()
        label.text = "HAPPENING NOW"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .systemBlue
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

    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let specialEventLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [specialEventLabel, titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(happeningNow)
        contentView.addSubview(bannerImageView)
        bannerImageView.addSubview(overlayView)
        overlayView.addSubview(textStackView)
        
        NSLayoutConstraint.activate([
            happeningNow.topAnchor.constraint(equalTo: contentView.topAnchor),
            happeningNow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            
            bannerImageView.topAnchor.constraint(equalTo: happeningNow.bottomAnchor, constant: 8),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 210),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            overlayView.topAnchor.constraint(equalTo: bannerImageView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor),
            
            textStackView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 12),
            textStackView.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -12),
            textStackView.trailingAnchor.constraint(lessThanOrEqualTo: overlayView.trailingAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        if Bundle.main.path(forResource: "Main", ofType: "storyboardc") != nil {
            print("Main.storyboard in the Bundle")
        } else{
            print("Main.storyboard Not in the Bundle")
            return nil
        }
        super.init(coder: coder)
    }
    
    func configure(with event: EventModel) {
        bannerImageView.image = event.bannerImage
        titleLabel.text = event.title
        subtitleLabel.text = event.subtitle
        specialEventLabel.text = event.category.uppercased()
    }
}
