//
//  AccountEndpoints.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 16.07.2025.
//
import Foundation

enum AccountEndpoint {
    case list
    case single(id: String)
    case create
    case put(id: String)
    case delete(id: String)
}


extension AccountEndpoint: Endpoint {
    var method: EndpointType {
        switch self {
            
        case .list:
                .get
        case .single(id: let id):
                .get
        case .create:
                .post
        case .put(id: let id):
                .put
        case .delete(id: let id):
                .delete
        }
    }
    
    var authorized: Bool {
        true
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: "\(NetworkClient.Constants.baseURL)/accounts")!
    }
    
    var url: URL {
        switch self {
        case .list, .create:
            return baseURL
        case .single(id: let id), .put(id: let id), .delete(id: let id):
            return baseURL.appendingPathComponent("\(id)")
        }
    }
}
