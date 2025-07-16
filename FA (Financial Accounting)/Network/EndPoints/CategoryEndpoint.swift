//
//  CategoryEndpoint.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 16.07.2025.
//

import Foundation

enum CategoryEndpoint {
    case all
    case type(direction: Direction)
}

extension CategoryEndpoint: Endpoint {
    var authorized: Bool {
        true
    }
    
    var baseURL: URL {
        return URL(string: "\(NetworkClient.Constants.baseURL)/categories")!
    }
    
    var path: String {
        switch self {
            
        case .all:
            return ""
        case .type(let direction):
            return "/type/\(direction.rawValue)"
        }
    }
    
    var method: EndpointType {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    
}
