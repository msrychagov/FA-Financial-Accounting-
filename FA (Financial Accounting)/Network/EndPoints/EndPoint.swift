//
//  EndPoint.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 16.07.2025.
//

import Foundation

protocol Endpoint {
    var method: EndpointType { get }
    var authorized: Bool { get }
    var queryItems: [URLQueryItem]? { get }
    var baseURL: URL { get }
    var url: URL { get }
}

enum EndpointType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
