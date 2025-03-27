//
//  HomePresenter.swift
//  Ecommerce
//
//  Created by Dinar on 19.03.2025.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoaded()
    func didLoadCategoriesList(categories: [Categories])
    func didLoadProductsList(products: [Product])
    
    func searchButtonTapped()
}

class HomePresenter {
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol
    var interactor: HomeInteractorProtocol
    
    init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol){
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterProtocol{
    
    func viewDidLoaded(){
        interactor.loadCatgeoryItems()
        interactor.loadProductsItems()
    }
    
    func didLoadCategoriesList(categories: [Categories]) {
        DispatchQueue.main.async {
            self.view?.showCategories(categories: categories)
        }
    }
    
    func didLoadProductsList(products: [Product]) {
        DispatchQueue.main.async {
            self.view?.showProducts(products: products)
        }
    }
    
    func searchButtonTapped(){
        router.navigateToSearch()
    }
}

