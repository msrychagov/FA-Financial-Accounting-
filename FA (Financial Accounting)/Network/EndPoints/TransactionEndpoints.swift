//
//  TransactionEndpoints.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 16.07.2025.
//
import Foundation

enum TransactionEndpoints {
    case list(accountId: String, startDate: Date, endDate: Date)
    case create
    case put(id: Int)
    case delete(id: Int)
}

extension TransactionEndpoints: Endpoint {
    
    
    var baseURL: String {
        return "https://shmr-finance.ru/api/v1/transactions"
    }
    
    var path: String {
        switch self {
        case .list(accountId: let accountId, startDate: let startDate, endDate: let endDate):
            return "/account/\(accountId)/period"
        case .create:
            return ""
        case .put(let id), .delete(let id):
            return "/\(id)"
        }
    }
    
    var method: EndpointType {
        switch self {
        case .list:
            return .get
        case .create:
            return .post
        case .put(id: let id):
            return .put
        case .delete(id: let id):
            return .delete
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
            
        case .list(accountId: let accountId, startDate: let startDate, endDate: let endDate):
            return [
                URLQueryItem(name: "startDate", value: startDate.endpointDate()),
                URLQueryItem(name: "endDate", value: endDate.endpointDate())
            ]
        default:
            return []
        }
    }
}



