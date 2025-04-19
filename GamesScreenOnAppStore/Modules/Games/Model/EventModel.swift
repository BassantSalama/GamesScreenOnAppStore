

import UIKit

struct EventModel {
    
    let bannerImage: UIImage
    let title: String
    let subtitle: String
    let category: String
    
    
    static  let events : [EventModel] = [
        EventModel(
            bannerImage: UIImage(named: "event2")!,
            title: "Return to Breezie Hollow",
            subtitle: "Join Fluttershy on a breezy quest!",
            category: "SPECIAL EVENT"
        ),
        EventModel(
            bannerImage: UIImage(named: "event1")!,
            title: "Hoppy Easter",
            subtitle: "Bunny up for rewards this Ester season!",
            category: "SPECIAL EVENT"
        ),
        EventModel(
            bannerImage: UIImage(named: "event2")!,
            title: "Return to Breezie Hollow",
            subtitle: "Join Fluttershy on a breezy quest!",
            category: "SPECIAL EVENT"
        ),
        EventModel(
            bannerImage: UIImage(named: "event1")!,
            title: "Hoppy Easter",
            subtitle: "Bunny up for rewards this Ester season!",
            category: "SPECIAL EVENT"
        )
    ]
    
}

