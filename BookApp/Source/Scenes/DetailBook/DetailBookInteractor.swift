//
//  DetailBookInteractor.swift
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

protocol DetailBookBusinessLogic
{
  func getBook(request: DetailBook.GetBook.Request)
}

protocol DetailBookDataStore
{
    var book: Book? { get set }
}

final class DetailBookInteractor: DetailBookBusinessLogic, DetailBookDataStore
{
    var book: Book?
    var presenter: DetailBookPresentationLogic?
  
  // MARK: Do something
  
  func getBook(request: DetailBook.GetBook.Request)
  {
      if let book = book {
          let response = DetailBook.GetBook.Response(book: book)
          presenter?.presentBook(response: response)
      }
  }
}
