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
    var baseURL: URL {
        return URL(string: "https://shmr-finance.ru/api/v1/categories")!
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
