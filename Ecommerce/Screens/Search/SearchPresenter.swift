//
//  SearchPresenter.swift
//  Ecommerce
//
//  Created by Dinar on 24.03.2025.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoaded()
}

class SearchPresenter {
    weak var view: SearchViewProtocol?
    var router: SearchRouterProtocol
    var interactor: SearchInteractorProtocol
    
    init(interactor: SearchInteractorProtocol, router: SearchRouterProtocol){
        self.interactor = interactor
        self.router = router
    }
}

extension SearchPresenter: SearchPresenterProtocol{
    
    func viewDidLoaded(){

    }
}
