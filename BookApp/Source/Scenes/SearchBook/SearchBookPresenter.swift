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

protocol SearchBookPresentationLogic
{
  func presentFetchedBooks(response: SearchBook.FetchBooks.Response)
}

final class SearchBookPresenter: SearchBookPresentationLogic
{
    weak var viewController: SearchBookDisplayLogic?

    func presentFetchedBooks(response: SearchBook.FetchBooks.Response) {
  
        var displayedBooks: [SearchBook.FetchBooks.ViewModel.DisplayedBook] = []
        for book in response.books.items {
            let book = book.volumeInfo
            let author = book.authors.joined(separator: ", ")
            let thumbnailURL = URL(string: book.imageLinks!.thumbnail)!
            let displayedBook = SearchBook.FetchBooks.ViewModel.DisplayedBook(title: book.title,
                                                                              author: author,
                                                                              publishedDate: book.publishedDate,
                                                                              thumbnailURL: thumbnailURL)
            displayedBooks.append(displayedBook)
        }
        let viewModel = SearchBook.FetchBooks.ViewModel(displayedBooks: displayedBooks)
        viewController?.displayFetchBooks(viewModel: viewModel)
    }
}
