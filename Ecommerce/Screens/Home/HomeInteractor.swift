//
//  HomeInteractor.swift
//  Ecommerce
//
//  Created by Dinar on 19.03.2025.
//

import Foundation

struct CategoriesEndpoint: EndpointProvider {
    var path: String { "/api/v1/categories" }
    var method: RequestMethod { .get }
    var task: RequestTask { .plain }
}

struct ProductsEndpoint: EndpointProvider {
    private let offset: Int
    private let limit: Int
    
    init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
    
    var path: String { "/api/v1/products" }
    var method: RequestMethod { .get }
    var task: RequestTask {
        .queryParameters(parameters: [
            "offset": String(offset),
            "limit": String(limit)
        ])
    }
}

protocol HomeInteractorProtocol: AnyObject {
    func loadCatgeoryItems()
    func loadProductsItems()
}

class HomeInteractor {
    weak var presenter : HomePresenterProtocol?
    private let apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol = ApiClient()) {
        self.apiClient = apiClient
    }
    
    let networkManager = NetworkManager.shared
    let viewModel = HomeViewModel()
}

extension HomeInteractor: HomeInteractorProtocol {
    func loadCatgeoryItems() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let endpoint = CategoriesEndpoint()
                let response = try await apiClient.asyncRequest(endpoint: endpoint)
                let categories = try JSONDecoder().decode([Categories].self, from: response.data)
                self.viewModel.categoriesList = categories
                self.presenter?.didLoadCategoriesList(categories: categories)
            } catch let error as ApiError {
                print(error)
            } catch {
                print(error)
            }
        }
    }
    
    
    func loadProductsItems() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let endpoint = ProductsEndpoint(offset: 0, limit: 10)
                let response = try await apiClient.asyncRequest(endpoint: endpoint)
                let products = try JSONDecoder().decode([Product].self, from: response.data)
                self.viewModel.productsList = products
                self.presenter?.didLoadProductsList(products: products)
            } catch let error as ApiError {
                print(error)
            } catch {
                print(error)
            }
        }
    }
}
