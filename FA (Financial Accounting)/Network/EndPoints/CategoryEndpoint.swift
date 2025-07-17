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
    var method: EndpointType {
        return .get
    }
    
    var authorized: Bool {
        true
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: "\(NetworkClient.Constants.baseURL)/categories")!
    }
    
    var url: URL {
        switch self {
            
        case .all:
            return baseURL
        case .type(let direction):
            return baseURL
                .appendingPathComponent("type")
                .appendingPathComponent("\(direction == .income)")
        }
    }
}
