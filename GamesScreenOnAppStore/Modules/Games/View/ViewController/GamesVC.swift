
import UIKit

// MARK: - GamesViewController

class GamesViewController: UIViewController {
    
    // MARK: - Properties
    
    private var gameCollectionView: UICollectionView!
    private let viewModel: GamesViewModel
    private let sectionProvider: GamesSectionProvider

    // MARK: - Initialization
    
    init(viewModel: GamesViewModel = GamesViewModel()) {
        self.viewModel = viewModel
        self.sectionProvider = GamesSectionProvider(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        configureCollectionView()
    }

    // MARK: - Setup Methods

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
        gameCollectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: sectionProvider.createLayout()
        )
        gameCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        gameCollectionView.backgroundColor = .systemBackground
        gameCollectionView.dataSource = sectionProvider

        registerCellsAndHeaders()
        view.addSubview(gameCollectionView)
    }

    private func registerCellsAndHeaders() {
        gameCollectionView.register(CategoryChipCell.self, forCellWithReuseIdentifier: CategoryChipCell.reuseID)
        gameCollectionView.register(FeaturedBannerCell.self, forCellWithReuseIdentifier: FeaturedBannerCell.identifier)
        gameCollectionView.register(GameCell.self, forCellWithReuseIdentifier: GameCell.identifier)
        gameCollectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        gameCollectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.identifier
        )
    }
}
