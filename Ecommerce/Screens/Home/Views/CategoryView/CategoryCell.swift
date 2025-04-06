//
//  CategoryCell.swift
//  Ecommerce
//
//  Created by Dinar on 23.03.2025.
//

import UIKit
import Kingfisher


final class CategoryCell: UICollectionViewCell {
    static let id = "CategoryCellView"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
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
    
    func configure(with category: Categories) {
        self.nameLabel.text = category.name
        if let url = URL(string: category.image) {
            imageView.kf.setImage(
                with: url,
                placeholder: R.Images.Common.noImageStub,
                options: [.transition(.fade(0.2))]
            )
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.layer.cornerRadius = imageView.frame.width / 2
    }
}

private extension CategoryCell {
    func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
    }
    
    func constraintsViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func configureAppearance() {
        backgroundColor = .white
    }
}
