//
//  EndpointProvider.swift
//  Ecommerce
//
//  Created by Dinar on 02.04.2025.
//


import Foundation

enum RequestTask {
    case plain
    case bodyParameters(parameters: [String: Any])
    case queryParameters(parameters: [String: String])
    case requestCustomJSONEncodable(request: Encodable)
}

protocol  EndpointProvider {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var task: RequestTask { get }
}

extension EndpointProvider {
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "api.escuelajs.co"
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    func  asURLRequest () throws -> URLRequest {
        var urlComponents =  URLComponents ()
        urlComponents.scheme = scheme
        urlComponents.host =   baseURL
        urlComponents.path = path
        
        switch task {
        case let .queryParameters(parameters):
            let queryItems: [URLQueryItem] = parameters.map { .init(name: $0.key, value: $0.value) }
            urlComponents.queryItems = queryItems
        default:
            break
        }
        
        guard let url = urlComponents.url else {
            throw ApiError (errorCode: "ERROR-0" , message: "URL error" )
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")
        
        if let headers {
            for (headerField, headerValue) in headers {
                urlRequest.addValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        
        switch task {
        case .plain:
            break
            
        case let .bodyParameters(parameters):
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                throw ApiError (errorCode: "ERROR-0" , message: "URL error" )
            }
        default:
            break
        }
        return urlRequest
    }
}
