

import Foundation

enum GamesSection: Int, CaseIterable {
    case categoryChips
    case nowAvaliable
    case mustPlay
    case moreGames
    case appleArcadeGames
    case topFreeGames
    case topPaidGames
    case basedOnYourDownloads
    case exploreMoreGames
    case events
}
extension GamesSection {
    var title: String? {
        switch self {
        case .mustPlay: return "Must-Play Games"
        case .moreGames: return "More Games You Might Like"
        case .appleArcadeGames: return "Apple Arcade Games for you"
        case .topFreeGames: return "Top Free Games"
        case .topPaidGames: return "Top Paid Games"
        case .basedOnYourDownloads: return "Based On Your Downloads"
        case .exploreMoreGames: return "Explore More Games"
        case .events: return "Events You Might Like"
        default: return nil
        }
    }
}
