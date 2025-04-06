//
//  ProductsListView.swift
//  Ecommerce
//
//  Created by Dinar on 23.03.2025.
//

import UIKit

final class ProductsListView: UIView {
    
    private var productsList: [Product] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white 
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addSubviews()
        setupLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProducts(_ products: [Product]) {
        self.productsList = products
        collectionView.reloadData()
    }
}


private extension ProductsListView {
    
    func configureView() {
        backgroundColor = .white
    }
    
    func addSubviews() {
        addSubview(collectionView)
        collectionView.register(ProductCell.self,
                                forCellWithReuseIdentifier: ProductCell.id)
    }
    
    func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}


//MARK: - UICollectionViewDataSource
extension ProductsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.id, for: indexPath) as? ProductCell else { return UICollectionViewCell() }
        
        let product = productsList[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProductsListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat = 6
            let collectionViewWidth = collectionView.frame.width
            let cellWidth = (collectionViewWidth - padding) / 2
            return CGSize(width: cellWidth, height: 255)
        }
}

