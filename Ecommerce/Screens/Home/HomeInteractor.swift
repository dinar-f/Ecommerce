//
//  HomeInteractor.swift
//  Ecommerce
//
//  Created by Dinar on 19.03.2025.
//


protocol HomeInteractorProtocol: AnyObject {
    func loadCatgeoryItems()
    func loadProductsItems()
}

class HomeInteractor {
    weak var presenter : HomePresenterProtocol?
    
    let networkManager = NetworkManager.shared
    let viewModel = HomeViewModel()
}

extension HomeInteractor: HomeInteractorProtocol {
    func loadCatgeoryItems() {
        print(123)
    }
    
    
    func loadProductsItems() {
        networkManager.request { result in
            switch result {
            case .success(let data):
                self.viewModel.productsList = data
                self.presenter?.didLoadProductsList(products: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


//func loadCatgeoryItems() {
//    //        networkManager.request { result in
//    //            switch result {
//    //            case .success(let data):
//    //                self.viewModel.categoriesList = data
//    //                self.presenter?.didLoadCategoriesList(categories: data)
//    //            case .failure(let error):
//    //                print(error)
//    //            }
//    //        }
//}
