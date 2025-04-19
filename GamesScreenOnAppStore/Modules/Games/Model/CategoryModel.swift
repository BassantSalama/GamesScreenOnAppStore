
import UIKit
struct CategoryModel {
    let title: String
    let iconName: UIImage?
    
    static let categories: [CategoryModel] = [
        CategoryModel(title: "AR Games", iconName: UIImage(named: "AR Games")),
        CategoryModel(title: "Racing", iconName: UIImage(named: "racing")),
        CategoryModel(title: "Board", iconName: UIImage(named: "board")),
        CategoryModel(title: "Card",iconName: UIImage(named: "card")),
        CategoryModel(title: "Simulation", iconName: UIImage(named: "simulation")),
        CategoryModel(title: "Puzzle", iconName: UIImage(named: "puzzle"))
    ]
}
