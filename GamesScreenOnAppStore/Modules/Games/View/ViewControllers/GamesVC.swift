


import UIKit

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

final class GamesViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private let gamesViewModel = GamesViewModel()
    private let featureViewModel = FeaturedGamesViewModel()
    private let gamesInfoViewModel = GamesInfoViewModel()
    private let eventViewModel = EventViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .black
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(CategoryChipCell.self, forCellWithReuseIdentifier: CategoryChipCell.reuseID)
        collectionView.register(FeaturedBannerCell.self, forCellWithReuseIdentifier: FeaturedBannerCell.identifier)
        collectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.identifier)
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.identifier)
        
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let sectionType = GamesSection(rawValue: sectionIndex) else {
                return nil
            }
            
            let section: NSCollectionLayoutSection
            
            switch sectionType {
            case .categoryChips:
                section = self.createChipsSection()
            case .nowAvaliable:
                section = self.featuredBannerSection()
            case .mustPlay, .moreGames:
                section = self.gameListSection()
            case .appleArcadeGames:
                section = self.gameListSection()
            case .topFreeGames:
                section = self.gameListSection()
            case .topPaidGames:
                section = self.gameListSection()
            case .basedOnYourDownloads:
                section = self.gameListSection()
            case .exploreMoreGames:
                section = self.gameListSection()
            case .events:
                section = self.eventSection()
            }
            
            
            if sectionType == .mustPlay || sectionType == .moreGames {
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(40))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
            }
            
            return section
        }
    }
    
    private func createChipsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(32))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        section.interGroupSpacing = 8
        return section
    }
    
    private func featuredBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.97), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 8)
        return section
    }
    
    private func gameListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.98),
            heightDimension: .absolute(80 * 3 + 16 * 2)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 3
        )
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 16, trailing: 8)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func eventSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.97), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 8)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}


extension GamesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return GamesSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = GamesSection(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .categoryChips:
            return gamesViewModel.categories.count
        case .nowAvaliable:
            return featureViewModel.featuredGames.count
        case .mustPlay:
            return gamesInfoViewModel.mustPlayGames.count
        case .moreGames:
            return gamesInfoViewModel.moreGames.count
        case .appleArcadeGames:
            return gamesInfoViewModel.appleArcadeGames.count
        case .topFreeGames:
            return gamesInfoViewModel.topFreeGames.count
        case .topPaidGames:
            return gamesInfoViewModel.moreGames.count
        case .basedOnYourDownloads:
            return gamesInfoViewModel.moreGames.count
        case .exploreMoreGames:
            return gamesInfoViewModel.moreGames.count
        case .events:
            return eventViewModel.events.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = GamesSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch sectionType {
        case .categoryChips:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryChipCell.reuseID, for: indexPath) as! CategoryChipCell
            let chip = gamesViewModel.categories[indexPath.item]
            cell.configure(with: chip)
            return cell
        case .nowAvaliable:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedBannerCell.identifier, for: indexPath) as! FeaturedBannerCell
            let game = featureViewModel.featuredGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .mustPlay:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesInfoViewModel.mustPlayGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .moreGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesInfoViewModel.moreGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .appleArcadeGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesInfoViewModel.appleArcadeGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .topFreeGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesInfoViewModel.topFreeGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .topPaidGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesInfoViewModel.topPaidGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .basedOnYourDownloads:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesInfoViewModel.basedOnYourDownloads[indexPath.item]
            cell.configure(with: game)
            return cell
        case .exploreMoreGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesInfoViewModel.exploreMoreGames[indexPath.item]
            cell.configure(with: game)
            return cell
            
            
        case .events:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
            let event = eventViewModel.events[indexPath.item]
            cell.configure(with: event)
            return cell
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.identifier,
            for: indexPath
        ) as! SectionHeaderView
        
        let title: String
        switch GamesSection(rawValue: indexPath.section) {
        case .mustPlay:
            title = "Must-Play Games"
        case .moreGames:
            title = "More Games You Might Like"
        case .appleArcadeGames:
            title = "Apple Arcade Games for you"
        case .topFreeGames:
            title = "Top Free Games"
        case .topPaidGames:
            title = "Top Paid Games"
        case .basedOnYourDownloads:
            title = "Based On Your Downloads"
        case .exploreMoreGames:
            title = "Explore More Games"
            
        case .events:
            title = "Events You Might Like"
        default:
            title = ""
        }
        
        header.configure(title: title)
        return header
    }
}

