//
//  SearchBookModels.swift
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

enum SearchBook
{
  // MARK: Use cases
  
  enum FetchBooks
  {
    struct Request
    {
        let title: String
        let startIndex: Int
    }
    struct Response
    {
        var books: [Book]
        struct Error {
            var message: String
        }
    }
    struct ViewModel
    {
        struct DisplayedBook {
            var title: String
            var author: String
            var publishedDate: String
            var thumbnailURL: URL?
        }
        struct Error {
            var message: String
        }
        var displayedBooks: [DisplayedBook]
    }
  }
}
