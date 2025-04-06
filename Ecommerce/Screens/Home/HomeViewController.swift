//
//  HomeViewController.swift
//  Ecommerce
//
//  Created by Dinar on 19.03.2025.
//

import UIKit

enum Section: Int, CaseIterable {
    case categories
    case products
    
    var title: String {
        switch self {
        case .categories:
            return "Categories"
        case .products:
            return "Products"
        }
    }
}

enum Item: Hashable {
    case categories(Categories)
    case product(Product)
}

protocol HomeViewProtocol: AnyObject {
    func showCategories(categories: [Categories])
    func showProducts(products: [Product])
}

class HomeViewController: UIViewController {
    
    var presenter: HomePresenterProtocol?
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    private var categoriesList: [Categories] = []
    private var productsList: [Product] = []
    
    private let navBar = HomeNavBar()
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collection.backgroundColor = .white
        return collection
    }()
    
    let titlelAbel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        setupView()
        setDelegates()
        loadData()
        configureDataSource()
    }
}

// MARK: - Setup
private extension HomeViewController {
    
    func loadData() {
        categoriesList = [
            Categories(id: 1, name: "Electronics", image: "https://example.com/electronics.jpg"),
            Categories(id: 2, name: "Clothing", image: "https://example.com/clothing.jpg"),
            Categories(id: 3, name: "Clothing", image: "https://example.com/clothing.jpg"),
            Categories(id: 4, name: "Clothing", image: "https://example.com/clothing.jpg"),
            Categories(id: 5, name: "Clothing", image: "https://example.com/clothing.jpg"),
            Categories(id: 6, name: "Clothing", image: "https://example.com/clothing.jpg"),
            Categories(id: 7, name: "Clothing", image: "https://example.com/clothing.jpg"),
            Categories(id: 8, name: "Clothing", image: "https://example.com/clothing.jpg"),
            Categories(id: 9, name: "Clothing", image: "https://example.com/clothing.jpg"),
            Categories(id: 10, name: "Clothing", image: "https://example.com/clothing.jpg"),
        ]
        
        productsList = [
            Product(
                id: 1,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),
            Product(
                id: 2,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),
            Product(
                id: 3,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),Product(
                id: 4,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),Product(
                id: 5,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),Product(
                id: 6,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),Product(
                id: 7,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),Product(
                id: 8,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),Product(
                id: 9,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),Product(
                id: 10,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),Product(
                id: 11,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            ),Product(
                id: 12,
                title: "Smartphone",
                price: 599.99,
                description: "Latest model smartphone",
                category: Product.Category(id: 1, name: "Electronics"),
                images: ["https://example.com/phone1.jpg", "https://example.com/phone2.jpg"]
            )
        ]
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        addSubviews()
        setupLayout()
    }
    
    func setDelegates() {
        navBar.delegate = self
        collectionView.delegate = self
    }
    
    func addSubviews() {
        view.addSubview(navBar)
        view.addSubview(collectionView)
    }
    
    func setupLayout() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func showProducts(products: [Product]) {
        self.productsList = products
        applySnapshot()
    }
    
    func showCategories(categories: [Categories]) {
        self.categoriesList = categories
        applySnapshot()
    }
}

// MARK: - HomeNavBarDelegate
extension HomeViewController: HomeNavBarDelegate {
    func searchButtonTapped() {
        presenter?.searchButtonTapped()
    }
}

// MARK: - CollectionView DataSource & Layout
extension HomeViewController {
    private func configureDataSource() {
        let categoryCellRegistration = UICollectionView.CellRegistration<CategoryCell, Categories> { cell, _, category in
            cell.configure(with: category)
        }
        
        let productCellRegistration = UICollectionView.CellRegistration<ProductCell, Product> { cell, _, product in
            cell.configure(with: product)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<HeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { headerView, _, indexPath in
            guard let section = Section(rawValue: indexPath.section) else { return }
            headerView.configure(with: section.title)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            collectionView, indexPath, item -> UICollectionViewCell? in
            
            switch item {
            case .categories(let category):
                return collectionView.dequeueConfiguredReusableCell(
                    using: categoryCellRegistration,
                    for: indexPath,
                    item: category
                )
            case .product(let product):
                return collectionView.dequeueConfiguredReusableCell(
                    using: productCellRegistration,
                    for: indexPath,
                    item: product
                )
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration,
                    for: indexPath
                )
            }
            return nil
        }
        
        applySnapshot()
    }

    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.categories, .products])
        snapshot.appendItems(categoriesList.map { Item.categories($0) }, toSection: .categories)
        snapshot.appendItems(productsList.map { Item.product($0) }, toSection: .products)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            let sectionLayout: NSCollectionLayoutSection
            
            switch section {
            case .categories:
                sectionLayout = self.createCategoriesSection()
            case .products:
                sectionLayout = self.createProductsSection()
            }
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(64)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            sectionLayout.boundarySupplementaryItems = [header]
            
            return sectionLayout
        }
        return layout
    }
    
    private func createCategoriesSection() -> NSCollectionLayoutSection {
        let itemsPerRow: CGFloat = 4
        let spacing: CGFloat = 8
        let sectionInsets: CGFloat = 16
        
        let availableWidth = UIScreen.main.bounds.width - sectionInsets * 2
        let itemWidth = (availableWidth - spacing * (itemsPerRow - 1)) / itemsPerRow
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(110))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(110))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionInsets, bottom: 0, trailing: sectionInsets)
        return section
    }
    
    private func createProductsSection() -> NSCollectionLayoutSection {
        let spacing: CGFloat = 5
        let rowSpacing: CGFloat = 8
        let sectionInsets: CGFloat = 16
        let itemHeight: CGFloat = 255
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let rowGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(itemHeight))
        let rowGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rowGroupSize, subitem: item, count: 2)
        rowGroup.interItemSpacing = .fixed(spacing)
        
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(itemHeight * 2 + rowSpacing))
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: verticalGroupSize,
            subitems: [rowGroup, rowGroup]
        )
        verticalGroup.interItemSpacing = .fixed(rowSpacing)
        
        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionInsets, bottom: 0, trailing: sectionInsets)
        return section
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        if case .product(let product) = item {
            presenter?.didSelectProduct(product)
        }
    }
}
