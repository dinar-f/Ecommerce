//
//  SearchModuleBuilder.swift
//  Ecommerce
//
//  Created by Dinar on 24.03.2025.
//

import Foundation

class SearchModuleBuilder {
    static func build() -> SearchViewController {
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(interactor: interactor, router: router)
        let viewController = SearchViewController()
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}

