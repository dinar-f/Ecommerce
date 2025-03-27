//
//  SearchInteractor.swift
//  Ecommerce
//
//  Created by Dinar on 24.03.2025.
//


protocol SearchInteractorProtocol: AnyObject {

}

class SearchInteractor {
    weak var presenter : SearchPresenterProtocol?
    
    let networkManager = NetworkManager.shared
    let viewModel = HomeViewModel()
}

extension SearchInteractor: SearchInteractorProtocol {

}
