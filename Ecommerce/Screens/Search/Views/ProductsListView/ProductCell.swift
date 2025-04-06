//
//  ProductCell.swift
//  Ecommerce
//
//  Created by Dinar on 23.03.2025.
//

import UIKit
import Kingfisher


final class ProductCell: UICollectionViewCell {
    static let id = "ProductCellView"
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.layer.masksToBounds = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = R.Colors.secondary
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        constraintsViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        self.nameLabel.text = product.title
        self.categoryLabel.text = product.category.name
        self.priceLabel.text = "\(product.price) $"
        if let url = URL(string: product.images[0]) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

private extension ProductCell {
    func setupViews() {
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
    }
    
    func constraintsViews() {
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            cellBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 175),
            
            imageView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -5),
            
            nameLabel.topAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func configureAppearance() {
        backgroundColor = .white
    }
}
