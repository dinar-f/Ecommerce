//
//  ProductPresenter.swift
//  Ecommerce
//
//  Created by Dinar on 31.03.2025.
//

import Foundation

protocol ProductPresenterProtocol: AnyObject {
    func viewDidLoaded()

}

class ProductPresenter {
    weak var view: ProductViewProtocol?
    var router: ProductRouterProtocol
    var interactor: ProductInteractorProtocol
    
    init(interactor: ProductInteractorProtocol, router: ProductRouterProtocol){
        self.interactor = interactor
        self.router = router
    }
}

extension ProductPresenter: ProductPresenterProtocol {
    
    func viewDidLoaded(){
        let productInfo = interactor.product
        view?.showProduct(productInfo)
    }
    
}

