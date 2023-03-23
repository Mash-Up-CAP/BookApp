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

protocol SearchBookWorkerProtocol {
    func requestAPIBooks(title: String, startIndex: Int) async throws -> [Book]
}

final class SearchBookWorker: SearchBookWorkerProtocol {
    private var booksStore: BooksAPIProtocol
    
    init(booksStore: BooksAPIProtocol = BooksAPI()) {
        self.booksStore = booksStore
    }
    
    func requestAPIBooks(title: String, startIndex: Int) async throws -> [Book] {
        let request = SearchBookRequest(q: title, startIndex: "\(startIndex)")
        let data = try await booksStore.getBookRequest(request: request).items.map({ response in
            response.map { self.translate($0.volumeInfo) } })
       return data ?? []
    }
    
    private func translate(_ response: SearchBookResponse.BookItem.BookInfo) -> Book {
        return .init(title: response.title,
                  author: response.authors,
                  publishedDate: response.publishedDate,
                     thumbnailLink: response.imageLinks?.thumbnail,
                  description: response.description,
                  pageCount: response.pageCount,
                  publisher: response.publisher,
                  categories: response.categories)
        
    }
}
