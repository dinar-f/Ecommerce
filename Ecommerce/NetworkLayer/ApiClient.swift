//
//  ApiClient.swift
//  Ecommerce
//
//  Created by Dinar on 06.04.2025.
//

struct ErrorModel: Decodable {
    let errorCode: String
    let message: String
}

import Foundation

final class CustomResponse: CustomDebugStringConvertible, Equatable {
    let statusCode: Int
    let data: Data
    let request: URLRequest?
    let response: HTTPURLResponse?
    
    init(
        statusCode: Int,
        data: Data,
        request: URLRequest? = nil,
        response: HTTPURLResponse? = nil
    ) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
    
    var description: String {
        "Status Code: \(statusCode), Data Length: \(data.count)"
    }
    
    var debugDescription: String { description }
    
    static func == (lhs: CustomResponse, rhs: CustomResponse) -> Bool {
        lhs.statusCode == rhs.statusCode
        && lhs.data == rhs.data
        && lhs.response == rhs.response
    }
}



protocol ApiClientProtocol {
    func asyncRequest(endpoint: EndpointProvider) async throws -> CustomResponse
    func asyncUpload(endpoint: EndpointProvider) async throws -> CustomResponse
    func asyncDownload(fileURL: URL) async throws -> URL
    func asyncDownload(endpoint: EndpointProvider) async throws -> URL
}

final class ApiClient: ApiClientProtocol {
    func asyncUpload(endpoint: any EndpointProvider) async throws -> CustomResponse {
        let emptyRequest = try endpoint.asURLRequest()
        let (data, response) = try await URLSession.shared.data(for: emptyRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError(errorCode: "UPLOAD-ERROR", message: "Invalid upload response")
        }
        
        return CustomResponse(
            statusCode: httpResponse.statusCode,
            data: data,
            request: emptyRequest,
            response: httpResponse
        )
    }
    
    func asyncDownload(fileURL: URL) async throws -> URL {
        return fileURL
    }
    
    func asyncDownload(endpoint: any EndpointProvider) async throws -> URL {
        let request = try endpoint.asURLRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw ApiError(errorCode: "DOWNLOAD-ERROR", message: "Download failed")
        }
        
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(UUID().uuidString)
        try data.write(to: tempURL)
        
        return tempURL
    }
    
    
    private var session: URLSession
    
    // MARK: - Init
    init(session: URLSession) {
        self.session = session
    }
    
    convenience init() {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 300
        self.init(session: URLSession(configuration: configuration))
    }
    
    func asyncRequest(endpoint: EndpointProvider) async throws -> CustomResponse {
        do {
            let request = try endpoint.asURLRequest()
            let (data, response) = try await session.data(for: request)
            return try await manageResponse(
                data: data,
                request: request,
                response: response,
                endpoint: endpoint
            )
        } catch let error as ApiError {
            throw error
        } catch {
            throw ApiError (errorCode: "ERROR-0" , message: "URL error" )
        }
    }
}

// MARK: - Private methods
private extension ApiClient {
    func manageResponse(
        data: Data,
        request: URLRequest,
        response: URLResponse,
        endpoint: EndpointProvider
    ) async throws -> CustomResponse {
        guard let response = response as? HTTPURLResponse else {
            throw ApiError (errorCode: "ERROR-0" , message: "URL error" )
        }
        
        switch response.statusCode {
        case 200...299:
            return CustomResponse(
                statusCode: response.statusCode,
                data: data,
                request: request,
                response: response
            )
        case 404:
            throw ApiError (errorCode: "ERROR-0" , message: "URL error" )

        case 429:
            throw ApiError (errorCode: "ERROR-0" , message: "URL error" )

        case 502:
            throw ApiError (errorCode: "ERROR-0" , message: "URL error" )
            
            
        default:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let decodedError = try? decoder.decode(ErrorModel.self, from: data) else {
                throw ApiError (errorCode: "ERROR-0" , message: "URL error" )
            }
            throw ApiError (errorCode: "ERROR-0" , message: "URL error" )
        }
    }
}
