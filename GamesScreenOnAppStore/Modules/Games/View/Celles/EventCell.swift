


import UIKit


class EventCell: UICollectionViewCell {
    static let identifier = "EventCell"
    
    private let happeningNow: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

   

    private let bannerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
      
        contentView.addSubview(bannerImageView)
        contentView.addSubview(happeningNow)
       
        NSLayoutConstraint.activate([
           
            
            happeningNow.topAnchor.constraint(equalTo: contentView.topAnchor),
            happeningNow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            
         
            bannerImageView.topAnchor.constraint(equalTo: happeningNow.topAnchor, constant: 25),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 230),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with event: EventModel) {
        bannerImageView.image = event.bannerImage
        happeningNow.text = "HAPPENING NOW"
      
    }
}
