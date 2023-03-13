//
//  DetailBookModels.swift
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

enum DetailBook
{
  // MARK: Use cases
  
  enum GetBook
  {
    struct Request
    {
    }
    struct Response
    {
        var book: Book
    }
    struct ViewModel
    {
        struct DisplayedBook {
            var title: String
            var author: String?
            var thumbnailURL: URL?
            var pageCount: String
            var categories: String?
            var description: String?
            var publisher: String?
            var publishedDate: String
        }
        var displayedBook: DisplayedBook
    }
  }
}
