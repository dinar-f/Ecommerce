//
//  SearchViewController.swift
//  Ecommerce
//
//  Created by Dinar on 24.03.2025.
//

import UIKit

protocol SearchViewProtocol: AnyObject {

}

class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol?
    
    private let searchTextField = TextField(type: .search)
    
    let titlelAbel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.viewDidLoaded()
        addSubviews()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextField.becomeFirstResponder()
    }
}

private extension SearchViewController {
    
    func addSubviews() {
        view.addSubview(searchTextField)
    }
    
    func setupLayout() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor ,constant: 130),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
        ])
    }
}

extension SearchViewController: SearchViewProtocol {
   
}


