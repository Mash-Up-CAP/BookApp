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
    func presentFetchBookList(response: SearchBook.FetchBookList.Response)
    func presentFetchBookListError(response: SearchBook.FetchBookList.Response.Error)
}

final class SearchBookPresenter: SearchBookPresentationLogic {
    weak var viewController: SearchBookDisplayLogic?

    func presentFetchBookList(response: SearchBook.FetchBookList.Response) {
  
        var displayedBookList: [SearchBook.FetchBookList.ViewModel.DisplayedBook] = []
        for book in response.bookList {
            let author = book.author?.joined(separator: ", ") ?? "작자미상"
            let publishedDate = book.publishedDate ?? ""
            guard let thumbnailURL = URL(string: book.thumbnailLink ?? "") else { return }
            let displayedBook = SearchBook.FetchBookList.ViewModel.DisplayedBook(title: book.title,
                                                                              author: author,
                                                                              publishedDate: publishedDate,
                                                                              thumbnailURL: thumbnailURL)
            displayedBookList.append(displayedBook)
        }
            
        let viewModel = SearchBook.FetchBookList.ViewModel(displayedBookList: displayedBookList)
        self.viewController?.displayFetchBookList(viewModel: viewModel)
    }
    
    func presentFetchBookListError(response: SearchBook.FetchBookList.Response.Error) {
        let viewModel = SearchBook.FetchBookList.ViewModel.Error(message: response.message)
        self.viewController?.displayFetchBookListError(viewModel: viewModel)
    }
}
