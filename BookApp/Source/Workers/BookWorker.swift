//
//  BookWorker.swift
//  BookApp
//
//  Created by Julia on 2023/03/08.
//

import Foundation

final class BooksWorker {
    var booksStore: BooksStoreProtocol
    
    init(booksStore: BooksStoreProtocol) {
        self.booksStore = booksStore
    }
    
    func fetchBooks() async throws -> Books {
        let books = try await self.booksStore.fetchStaticBooks()
        return books
    }

}

protocol BooksStoreProtocol {
//    func fetchBooks(title: String) async throws -> [Book]
    func fetchStaticBooks() async throws -> Books
}
