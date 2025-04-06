//
//  HomeRouter.swift
//  Ecommerce
//
//  Created by Dinar on 19.03.2025.
//

import Foundation


protocol HomeRouterProtocol: AnyObject {
    func navigateToSearch()
    func navigateToProduct(with product: Product)
}

class HomeRouter: HomeRouterProtocol {
    
    weak var viewController: HomeViewController?
    
    func navigateToSearch() {
        let searchVC = SearchModuleBuilder.build()
        viewController?.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func navigateToProduct(with product: Product) {
        let productModule = ProductModuleBuilder.build(with: product)
        viewController?.navigationController?.pushViewController(productModule, animated: true)
    }
    
}

