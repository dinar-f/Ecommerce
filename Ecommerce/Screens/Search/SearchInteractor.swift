//
//  SearchInteractor.swift
//  Ecommerce
//
//  Created by Dinar on 24.03.2025.
//

import Foundation

struct FilteredProductsEndpoint: EndpointProvider {
    let query: String
    
    var path: String { "/api/v1/products/" }
    var method: RequestMethod { .get }
    var task: RequestTask {
        .queryParameters(parameters: ["title": query])
    }
}

protocol SearchInteractorProtocol: AnyObject {
    func loadFilteredProductsItems(with query: String)
}

class SearchInteractor {
    weak var presenter : SearchPresenterProtocol?
    
    private let apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol = ApiClient()) {
        self.apiClient = apiClient
    }
    
    let networkManager = NetworkManager.shared
    let viewModel = HomeViewModel()
}

extension SearchInteractor: SearchInteractorProtocol {
    func loadFilteredProductsItems(with query: String) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let endpoint = FilteredProductsEndpoint(query: query)
                let response = try await apiClient.asyncRequest(endpoint: endpoint)
                let products = try JSONDecoder().decode([Product].self, from: response.data)
                self.presenter?.didLoadFilteredProductsList(products: products)
            } catch let error as ApiError {
                print(error)
            } catch {
                print(error)
            }
        }
    }
}
