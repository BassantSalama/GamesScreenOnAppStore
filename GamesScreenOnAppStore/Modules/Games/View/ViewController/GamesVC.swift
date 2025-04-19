
import UIKit

class GamesViewController: UIViewController {
    
    private var gameCollectionView: UICollectionView!
    
    private let gamesViewModel = GamesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        configureCollectionView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
    }
    
    private func configureCollectionView() {
        setupCollectionView()
        registerCells()
        registerSupplementaryViews()
        setupDataSource()
        addCollectionViewToView()
    }
    
    private func setupCollectionView() {
        gameCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        gameCollectionView.backgroundColor = .systemBackground
        gameCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func registerCells() {
        gameCollectionView.register(CategoryChipCell.self, forCellWithReuseIdentifier: CategoryChipCell.reuseID)
        gameCollectionView.register(FeaturedBannerCell.self, forCellWithReuseIdentifier: FeaturedBannerCell.identifier)
        gameCollectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.identifier)
        gameCollectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
    }
    
    private func registerSupplementaryViews() {
        gameCollectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )
    }
    
    private func setupDataSource() {
        gameCollectionView.dataSource = self
    }
    
    private func addCollectionViewToView() {
        view.addSubview(gameCollectionView)
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
            case .mustPlay, .moreGames, .appleArcadeGames, .topFreeGames, .topPaidGames, .basedOnYourDownloads, .exploreMoreGames :
                section = self.gameListSection()
            case .events:
                section = self.eventSection()
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(260))
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
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 16, trailing: 8)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(240))
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
            return gamesViewModel.featuredGames.count
        case .mustPlay:
            return gamesViewModel.mustPlayGames.count
        case .moreGames:
            return gamesViewModel.moreGames.count
        case .appleArcadeGames:
            return gamesViewModel.appleArcadeGames.count
        case .topFreeGames:
            return gamesViewModel.topFreeGames.count
        case .topPaidGames:
            return gamesViewModel.moreGames.count
        case .basedOnYourDownloads:
            return gamesViewModel.moreGames.count
        case .exploreMoreGames:
            return gamesViewModel.moreGames.count
        case .events:
            return gamesViewModel.events.count
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
            let game = gamesViewModel.featuredGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .mustPlay:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesViewModel.mustPlayGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .moreGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesViewModel.moreGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .appleArcadeGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesViewModel.appleArcadeGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .topFreeGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesViewModel.topFreeGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .topPaidGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesViewModel.topPaidGames[indexPath.item]
            cell.configure(with: game)
            return cell
        case .basedOnYourDownloads:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesViewModel.basedOnYourDownloads[indexPath.item]
            cell.configure(with: game)
            return cell
        case .exploreMoreGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.identifier, for: indexPath) as! GameCell
            let game = gamesViewModel.exploreMoreGames[indexPath.item]
            cell.configure(with: game)
            return cell
            
        case .events:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as! EventCell
            let event = gamesViewModel.events[indexPath.item]
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
        
        
        let title = GamesSection(rawValue: indexPath.section)?.title ?? ""
        header.configure(title: title)
        return header
    }
}

