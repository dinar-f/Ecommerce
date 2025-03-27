//
//  HomeNavBar.swift
//  Ecommerce
//
//  Created by Dinar on 23.03.2025.
//


import UIKit

protocol HomeNavBarDelegate: AnyObject {
    func searchButtonTapped()
}

class HomeNavBar: UIView {
    
    weak var delegate: HomeNavBarDelegate?
    
    private let userAvatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Images.navBar.userAvatar
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let userNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.text = "Hi, User Name"
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.Colors.secondary
        label.font = R.Fonts.montserratRegular(with: 14)
        label.text = "Kazan"
        return label
    }()
    
    private let cartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Images.navBar.cart
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Images.navBar.search
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addsSubviews()
        setupLayout()
        setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchTapped))
        searchImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func searchTapped() {
        delegate?.searchButtonTapped()
    }
    
}

private extension HomeNavBar {
    
    func addsSubviews() {
        addSubview(userAvatarView)
        addSubview(userNamelabel)
        addSubview(cityLabel)
        addSubview(cartImageView)
        addSubview(searchImageView)
    }
    
    func configure() {
        backgroundColor = .white
    }
    
    func setupLayout() {
        userAvatarView.translatesAutoresizingMaskIntoConstraints = false
        userNamelabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cartImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userAvatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor ,constant: 14),
            userAvatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            userAvatarView.heightAnchor.constraint(equalToConstant: 44),
            userAvatarView.widthAnchor.constraint(equalToConstant: 44),
            userAvatarView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -18),
            
            userNamelabel.topAnchor.constraint(equalTo: userAvatarView.topAnchor, constant: 2),
            userNamelabel.leadingAnchor.constraint(equalTo: userAvatarView.trailingAnchor, constant: 8),
            
            cityLabel.topAnchor.constraint(equalTo: userNamelabel.bottomAnchor, constant: 4),
            cityLabel.leadingAnchor.constraint(equalTo: userAvatarView.trailingAnchor, constant: 8),
            
            cartImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            cartImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cartImageView.heightAnchor.constraint(equalToConstant: 28),
            cartImageView.widthAnchor.constraint(equalToConstant: 28),
            
            searchImageView.topAnchor.constraint(equalTo: cartImageView.topAnchor),
            searchImageView.trailingAnchor.constraint(equalTo: cartImageView.leadingAnchor, constant: -12),
            searchImageView.heightAnchor.constraint(equalToConstant: 28),
            searchImageView.widthAnchor.constraint(equalToConstant: 28),
        ])
    }
}

