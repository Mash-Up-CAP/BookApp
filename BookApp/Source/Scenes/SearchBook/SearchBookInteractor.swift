//
//  SearchBookInteractor.swift
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

protocol SearchBookBusinessLogic
{
    func fetchBooks(request: SearchBook.FetchBooks.Request)
}

protocol SearchBookDataStore
{
    var books: [Book]? { get }
}

final class SearchBookInteractor: SearchBookBusinessLogic, SearchBookDataStore
{
    var books: [Book]?
    
    var presenter: SearchBookPresentationLogic?
    private var worker: SearchBookWorkerProtocol?
    
    init(worker: SearchBookWorkerProtocol = SearchBookWorker()) {
        self.worker = worker
    }

    func fetchBooks(request: SearchBook.FetchBooks.Request) {
        guard let worker = worker else { return }
        Task {
            do {
                let bookModels = try await worker.requestAPIBooks(title: request.title, startIndex: request.startIndex)
                self.books = bookModels
                let response = SearchBook.FetchBooks.Response(books: bookModels)
                presenter?.presentFetchedBooks(response: response)
            } catch {
                presenter?.presentFetchedBooksError(response: .init(message: error.localizedDescription))
            }
        }
        
    }
}
