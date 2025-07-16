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
    var authorized: Bool {
        true
    }
    
    
    var baseURL: URL {
        return URL(string: "\(NetworkClient.Constants.baseURL)/accounts")!
    }
    
    var path: String {
        switch self {
        case .list, .create:
            return ""
        case .single(id: let id), .put(id: let id), .delete(id: let id):
            return "/\(id)"
        }
    }
    
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
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    
}
