//
//  HomeModuleBuilder.swift
//  Ecommerce
//
//  Created by Dinar on 19.03.2025.
//

import Foundation


class HomeModuleBuilder {
    static func build() -> HomeViewController {
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router)
        let viewController = HomeViewController()
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}

