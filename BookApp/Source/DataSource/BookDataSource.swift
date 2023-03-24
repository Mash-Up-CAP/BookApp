//
//  BooksAPI.swift
//  BookApp
//
//  Created by Julia on 2023/03/08.
//

import Foundation

protocol BookDataSourceProtocol {
    func getBook(request: SearchBookRequest) async throws -> SearchBookResponse
}

final class BookDataSource: BookDataSourceProtocol {

    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network(session: .shared)) {
        self.network = network
    }
    
    func getBook(request: SearchBookRequest) async throws -> SearchBookResponse {
        return try await network.request(request)
    }

}
