//
//  Request.swift
//  BookApp
//
//  Created by Julia on 2023/03/10.
//

import Foundation

enum NetworkError: Error {
    case badHttpResponse
    case invalidURL
    case failDecoding
}

protocol NetworkProtocol {
    func request<T: Request>(_ request: T) async throws -> T.Output
}
