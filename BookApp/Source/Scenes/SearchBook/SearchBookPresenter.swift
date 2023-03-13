//
//  SearchBookPresenter.swift
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

protocol SearchBookPresentationLogic {
    func presentFetchedBooks(response: SearchBook.FetchBooks.Response)
    func presentFetchedBooksError(response: SearchBook.FetchBooks.Response.Error)
}

final class SearchBookPresenter: SearchBookPresentationLogic
{
    weak var viewController: SearchBookDisplayLogic?

    func presentFetchedBooks(response: SearchBook.FetchBooks.Response) {
  
        var displayedBooks: [SearchBook.FetchBooks.ViewModel.DisplayedBook] = []
        for book in response.books {
            let author = book.author.joined(separator: ", ")
            let thumbnailURL = URL(string: book.thumbnailLink)!
            let displayedBook = SearchBook.FetchBooks.ViewModel.DisplayedBook(title: book.title,
                                                                              author: author,
                                                                              publishedDate: book.publishedDate,
                                                                              thumbnailURL: thumbnailURL)
            displayedBooks.append(displayedBook)
        }
        let viewModel = SearchBook.FetchBooks.ViewModel(displayedBooks: displayedBooks)
        self.viewController?.displayFetchBooks(viewModel: viewModel)
    }
    
    func presentFetchedBooksError(response: SearchBook.FetchBooks.Response.Error) {
        let viewModel = SearchBook.FetchBooks.ViewModel.Error(message: response.message)
        self.viewController?.displayFetchBooksError(viewModel: viewModel)
    }
}
