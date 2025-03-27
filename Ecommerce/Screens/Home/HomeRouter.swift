//
//  HomeRouter.swift
//  Ecommerce
//
//  Created by Dinar on 19.03.2025.
//

import Foundation


protocol HomeRouterProtocol: AnyObject {
    func navigateToSearch()

}

class HomeRouter: HomeRouterProtocol {
    
    weak var viewController: HomeViewController?
    
    func navigateToSearch() {
        let searchVC = SearchModuleBuilder.build()
        viewController?.navigationController?.pushViewController(searchVC, animated: true)
    }
}

