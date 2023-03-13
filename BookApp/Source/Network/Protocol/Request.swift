//
//  Request.swift
//  BookApp
//
//  Created by Julia on 2023/03/13.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

typealias QueryItems = [String: AnyHashable]

protocol Request {
    associatedtype Output: Decodable
    
    var method: HTTPMethod { get }
    var query: QueryItems { get }
    var contentType: String { get }
}

extension Request {
    var baseURL: String { "https://www.googleapis.com/books/v1/volumes" }
    var contentType: String { "application/json"}
}
