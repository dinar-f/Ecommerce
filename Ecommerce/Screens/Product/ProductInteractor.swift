//
//  ProductInteractor.swift
//  Ecommerce
//
//  Created by Dinar on 31.03.2025.
//

protocol ProductInteractorProtocol: AnyObject {
    var product: Product { get }
}

class ProductInteractor {
    weak var presenter : ProductPresenterProtocol?
    var product: Product
    
    init(product: Product) {
        self.product = product
    }
}

extension ProductInteractor: ProductInteractorProtocol {
    
}
