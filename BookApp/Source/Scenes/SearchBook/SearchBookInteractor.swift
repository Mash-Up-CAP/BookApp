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
  //var name: String { get set }
}

class SearchBookInteractor: SearchBookBusinessLogic, SearchBookDataStore
{
  var presenter: SearchBookPresentationLogic?
  var worker: SearchBookWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func fetchBooks(request: SearchBook.FetchBooks.Request)
  {
    worker = SearchBookWorker()
    worker?.doSomeWork()
    
    let response = SearchBook.FetchBooks.Response()
    presenter?.presentSomething(response: response)
  }
}