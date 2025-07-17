//
//  TransactionEndpoints.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 16.07.2025.
//
import Foundation

enum TransactionEndpoints {
    case list(accountId: Int, startDate: Date, endDate: Date)
    case details(id: Int)
    case create
    case put(id: Int)
    case delete(id: Int)
}

extension TransactionEndpoints: Endpoint {
    var method: EndpointType {
        switch self {
        case .list, .details:
            return .get
        case .create:
            return .post
        case .put(id: let id):
            return .put
        case .delete(id: let id):
            return .delete
        }
    }
    
    var authorized: Bool {
        true
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
            
        case .list(accountId: let accountId, startDate: let startDate, endDate: let endDate):
            return [
                URLQueryItem(name: "startDate", value: startDate.endpointDate()),
                URLQueryItem(name: "endDate", value: endDate.endpointDate())
            ]
        default:
            return nil
        }
    }
    
    var baseURL: URL {
        return URL(string: "\(NetworkClient.Constants.baseURL)/transactions")!
    }
    
    var url: URL {
        switch self {
        case .list(accountId: let accountId, startDate: let startDate, endDate: let endDate):
            return baseURL
                .appendingPathComponent("account")
                .appendingPathComponent("\(accountId)")
                .appendingPathComponent("period")
        case .create:
            return baseURL
        case .put(let id), .delete(let id), .details(let id):
            return baseURL.appendingPathComponent("\(id)")
        }
    }
}



