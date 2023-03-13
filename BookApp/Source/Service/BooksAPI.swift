//
//  BooksAPI.swift
//  BookApp
//
//  Created by Julia on 2023/03/08.
//

import Foundation

protocol BooksAPIProtocol {
    func getBookRequest(request: SearchBookRequest) async throws -> SearchBookResponse
}

//datasource 역할인가?
final class BooksAPI: BooksAPIProtocol {

    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network(session: .shared)) {
        self.network = network
    }
    
    func getBookRequest(request: SearchBookRequest) async throws -> SearchBookResponse {
        return try await network.request(request)
    }

}
