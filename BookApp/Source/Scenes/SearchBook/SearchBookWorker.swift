//
//  SearchBookWorker.swift
//  BookApp
//
//  Created by Julia on 2023/03/07.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

final class SearchBookWorker {
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
