import UIKit

struct FeaturedGame {
    let title: String
    let description: String
    let bannerImage: UIImage
    let iconImage: UIImage
    
    static let featuredGames: [FeaturedGame] = [
        FeaturedGame(
            title: "Clash of Clans",
            description: "WWE wrestlers join the fray!",
            bannerImage: UIImage(named: "clashOfClansBanner")!,
            iconImage:UIImage(named: "clash of clans")!
        ),
        FeaturedGame(
            title: "Honkai: Star Rail",
            description: "New 5-star character: Castorice",
            bannerImage: UIImage(named: "honkaiBanner")!,
            iconImage: UIImage(named: "honkaiLogo")!
            
        ),
        FeaturedGame(
            title: "Clash of Clans",
            description: "WWE wrestlers join the fray!",
            bannerImage: UIImage(named: "clashOfClansBanner")!,
            iconImage: UIImage(named: "clash of clans")!
        ),
        FeaturedGame(
            title: "Honkai: Star Rail",
            description: "New 5-star character: Castorice",
            bannerImage: UIImage(named: "honkaiBanner")!,
            iconImage: UIImage(named:  "honkaiLogo")!
        )
    ]
}
