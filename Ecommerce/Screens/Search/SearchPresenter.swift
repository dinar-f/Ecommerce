//
//  SearchPresenter.swift
//  Ecommerce
//
//  Created by Dinar on 24.03.2025.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoaded()
    func searchTextDidChange(with query: String)
    func didLoadFilteredProductsList(products: [Product])
}

class SearchPresenter {
    weak var view: SearchViewProtocol?
    var router: SearchRouterProtocol
    var interactor: SearchInteractorProtocol
    private var workItem: DispatchWorkItem?
    
    init(interactor: SearchInteractorProtocol, router: SearchRouterProtocol){
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol {

    func viewDidLoaded() {

    }
    
    func didLoadFilteredProductsList(products: [Product]) {
        DispatchQueue.main.async {
            if products.isEmpty {
                self.view?.showNotFoundBanner()
            } else {
                self.view?.showFilteredProducts(products: products)
            }
        }
    }
    
    func searchTextDidChange(with query: String) {
        workItem?.cancel()
        guard !query.isEmpty else { return }
        let task = DispatchWorkItem {
            self.interactor.loadFilteredProductsItems(with: query)
        }
        workItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: task)
    }
}

