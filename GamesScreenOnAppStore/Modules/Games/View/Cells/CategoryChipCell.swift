
import UIKit

class CategoryChipCell: UICollectionViewCell {
    
    static let reuseID = "CategoryChipCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let categoryIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
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
    
    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(categoryIcon)
        containerView.addSubview(categoryLabel)
    }

    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        categoryIcon.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            categoryIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            categoryIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            categoryIcon.widthAnchor.constraint(equalToConstant: 18),
            categoryIcon.heightAnchor.constraint(equalToConstant: 18),
            
            categoryLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryIcon.trailingAnchor, constant: 5),
            categoryLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }

    
    func configure(with catgory:CategoryModel) {
        categoryLabel.text = catgory.title
        
        if let iconName = catgory.iconName {
            categoryIcon.image = iconName
            
        }
    }
}
