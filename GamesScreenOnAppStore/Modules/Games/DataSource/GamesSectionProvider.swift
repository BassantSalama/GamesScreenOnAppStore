
import UIKit

final class GamesSectionProvider: NSObject {
    
    // MARK: - Properties
    
    private let viewModel: GamesViewModel

    // MARK: - Initialization
    
    init(viewModel: GamesViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Layout
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = GamesSection(rawValue: sectionIndex) else { return nil }
            return LayoutSectionBuilder.createLayout(for: section)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension GamesSectionProvider: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return GamesSection.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = GamesSection(rawValue: section) else { return 0 }
        switch sectionType {
        case .categoryChips:
            return viewModel.categories.count
        case .nowAvaliable:
            return viewModel.featuredGames.count
        case .mustPlay:
            return viewModel.mustPlayGames.count
        case .moreGames:
            return viewModel.moreGames.count
        case .appleArcadeGames:
            return viewModel.appleArcadeGames.count
        case .topFreeGames:
            return viewModel.topFreeGames.count
        case .topPaidGames:
            return viewModel.topPaidGames.count
        case .basedOnYourDownloads:
            return viewModel.basedOnYourDownloads.count
        case .exploreMoreGames:
            return viewModel.exploreMoreGames.count
        case .events:
            return viewModel.events.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = GamesSection(rawValue: indexPath.section) else { return UICollectionViewCell() }

        switch section {
        case .categoryChips:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryChipCell.reuseID, for: indexPath) as! CategoryChipCell
            cell.configure(with: viewModel.categories[indexPath.item])
            return cell
            
        case .nowAvaliable:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedBannerCell.identifier, for: indexPath) as! FeaturedBannerCell
            cell.configure(with: viewModel.featuredGames[indexPath.item])
            return cell
            
        case .mustPlay, .moreGames, .appleArcadeGames, .topFreeGames, .topPaidGames, .basedOnYourDownloads, .exploreMoreGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = getGames(for: section)[indexPath.item]
            cell.configure(with: game)
            return cell
            
        case .events:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
            cell.configure(with: viewModel.events[indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.identifier,
            for: indexPath
        ) as! SectionHeaderView
        
        header.configure(title: GamesSection(rawValue: indexPath.section)?.title ?? "")
        return header
    }

    // MARK: - Private Helpers

    private func getGames(for section: GamesSection) -> [Game] {
        switch section {
        case .mustPlay:
            return viewModel.mustPlayGames
        case .moreGames:
            return viewModel.moreGames
        case .appleArcadeGames:
            return viewModel.appleArcadeGames
        case .topFreeGames:
            return viewModel.topFreeGames
        case .topPaidGames:
            return viewModel.topPaidGames
        case .basedOnYourDownloads:
            return viewModel.basedOnYourDownloads
        case .exploreMoreGames:
            return viewModel.exploreMoreGames
        default:
            return []
        }
    }
}
