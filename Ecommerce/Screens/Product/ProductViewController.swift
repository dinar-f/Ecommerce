//
//  ProductViewController.swift
//  Ecommerce
//
//  Created by Dinar on 30.03.2025.
//

import UIKit


import UIKit

protocol ProductViewProtocol: AnyObject {
    func showProduct(_ product: Product)
}

class ProductViewController: UIViewController {
    
    var presenter: ProductPresenterProtocol?
    
    private lazy var imageSlider = ImageSliderView()
    private let colorSelectionView = ColorSelectionView()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(R.Images.Common.share?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private let productDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
        setupView()
        setDelegates()
    }
}

// MARK: - Setup
private extension ProductViewController {
    
    func setupView() {
        view.backgroundColor = .white
//        navigationController?.setNavigationBarHidden(true, animated: true)
        addSubviews()
        setupLayout()
    }
    
    func setDelegates() {
    }
    
    func addSubviews() {
        view.addSubview(imageSlider)
        view.addSubview(priceLabel)
        view.addSubview(shareButton)
        view.addSubview(productDetailsLabel)
        view.addSubview(colorSelectionView)
    }
    
    func setupLayout() {
        imageSlider.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        productDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        colorSelectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageSlider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            imageSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageSlider.heightAnchor.constraint(equalToConstant: 422),
            
            priceLabel.topAnchor.constraint(equalTo: imageSlider.bottomAnchor, constant: 18),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            shareButton.topAnchor.constraint(equalTo: imageSlider.bottomAnchor, constant: 18),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            shareButton.widthAnchor.constraint(equalToConstant: 30),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            
            productDetailsLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 14),
            productDetailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productDetailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            colorSelectionView.topAnchor.constraint(equalTo: productDetailsLabel.bottomAnchor, constant: 18),
            colorSelectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
}


// MARK: - ProductViewProtocol
extension ProductViewController: ProductViewProtocol {
    func showProduct(_ product: Product) {
        print(product)
        let imageUrls = product.images.compactMap { URL(string: $0) }
        imageSlider.setImages(imageUrls)
        priceLabel.text = "$\(product.price)"
        productDetailsLabel.text = product.description
    }
    
}
