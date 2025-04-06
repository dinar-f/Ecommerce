//
//  SearchViewController.swift
//  Ecommerce
//
//  Created by Dinar on 24.03.2025.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func showFilteredProducts(products: [Product])
    func showNotFoundBanner()
}

class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol?
    
    private let searchTextField = TextField(type: .search)
    private let productsList = ProductsListView()
    
    private let notFoundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.isHidden = true
        return stackView
    }()
    
    private let notFoundImageView: UIImageView = {
        let imageView = UIImageView(image: R.Images.Common.notFound)
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private let notFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "No products found"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let notFoundSublabel: UILabel = {
        let label = UILabel()
        label.text = "Try writing it differently or search in the general catalog"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.viewDidLoaded()
        addSubviews()
        setupLayout()
        addTargets()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextField.becomeFirstResponder()
    }
}

private extension SearchViewController {
    
    func addSubviews() {
        view.addSubview(searchTextField)
        view.addSubview(productsList)
        view.addSubview(notFoundStackView)
        notFoundStackView.addArrangedSubview(notFoundImageView)
        notFoundStackView.addArrangedSubview(notFoundLabel)
        notFoundStackView.addArrangedSubview(notFoundSublabel)
    }
    
    func setupLayout() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        productsList.translatesAutoresizingMaskIntoConstraints = false
        notFoundStackView.translatesAutoresizingMaskIntoConstraints = false
        notFoundImageView.translatesAutoresizingMaskIntoConstraints = false
        notFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        notFoundSublabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor ,constant: 130),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            
            productsList.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            productsList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productsList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            notFoundStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notFoundStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notFoundStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func addTargets() {
        searchTextField.addTarget(self, action: #selector(searchTextDidChange(_:)), for: .editingChanged)
    }
}

@objc extension SearchViewController {
    
    func searchTextDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        presenter?.searchTextDidChange(with: text)
    }
}

extension SearchViewController: SearchViewProtocol {
    func showNotFoundBanner() {
        productsList.isHidden = true
        notFoundStackView.isHidden = false
    }
    
    func showFilteredProducts(products: [Product]) {
        notFoundStackView.isHidden = true
        productsList.isHidden = false
        productsList.updateProducts(products)
    }
}


