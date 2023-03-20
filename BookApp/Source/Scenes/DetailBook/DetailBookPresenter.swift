//
//  DetailBookPresenter.swift
//  BookApp
//
//  Created by Julia on 2023/03/09.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol DetailBookPresentationLogic {
  func presentBook(response: DetailBook.GetBook.Response)
}

final class DetailBookPresenter: DetailBookPresentationLogic {
    
  weak var viewController: DetailBookDisplayLogic?
    
  func presentBook(response: DetailBook.GetBook.Response) {
        let book = response.book
        let authors = book.author?.joined(separator: ", ") ?? "작자미상"
        let pageInt = book.pageCount ?? 0
        let categories = book.categories?.joined(separator: " | ") ?? ""
        let description = book.description ?? ""
        let displayedBook = DetailBook.GetBook.ViewModel.DisplayedBook(title: book.title,
                                                                       author: authors,
                                                                       thumbnailLink: book.thumbnailLink ?? "",
                                                                       pageCount: "\(pageInt)쪽",
                                                                       categories: categories,
                                                                       description: description,
                                                                       publisher: book.publisher ?? "",
                                                                       publishedDate: book.publishedDate ?? "" )
       let viewModel = DetailBook.GetBook.ViewModel(displayedBook: displayedBook)
       viewController?.displayFetchBook(viewModel: viewModel)
  }
}
