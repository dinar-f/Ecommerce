//
//  ProductModuleBuilder.swift
//  Ecommerce
//
//  Created by Dinar on 31.03.2025.
//

import Foundation

class ProductModuleBuilder {
    static func build(with product: Product) -> ProductViewController {
        let interactor = ProductInteractor(product: product)
        let router = ProductRouter()
        let presenter = ProductPresenter(interactor: interactor, router: router)
        let viewController = ProductViewController()
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
