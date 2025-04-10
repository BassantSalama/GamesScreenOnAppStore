

import UIKit

class CategoryChipCell: UICollectionViewCell {
    
    static let reuseID = "CategoryChipCell"
    
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
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
        contentView.addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(label)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            iconView.widthAnchor.constraint(equalToConstant: 18),
            iconView.heightAnchor.constraint(equalToConstant: 18),
            
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(with catgory:CategoryModel) {
        label.text = catgory.title
        
        if let iconName = catgory.iconName {
            iconView.image = UIImage(systemName: iconName)
            
        }
    }
}
