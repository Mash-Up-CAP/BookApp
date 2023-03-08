//
//  BooksStaticStore.swift
//  BookApp
//
//  Created by Julia on 2023/03/08.
//

import Foundation

final class BooksStaticStore: BooksStoreProtocol {
    static let books: Books = Books(items: [
        Book(volumeInfo: VolumeInfo(title: "book1", authors: ["author1", "author1"], publisher: "", publishedDate: "2022-12-33",
                                    description: "", pageCount: 2, categories: nil, contentVersion: "",
                                    imageLinks: ImageLinks(thumbnail: "http://books.google.com/books/content?id=otbYDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"),
                                    previewLink: "", infoLink: "", subtitle: nil)),
        Book(volumeInfo: VolumeInfo(title: "book22", authors: ["author22"], publisher: "", publishedDate: "",
                                    description: "", pageCount: 233, categories: nil, contentVersion: "",
                                    imageLinks: ImageLinks(thumbnail: "http://books.google.com/books/content?id=jrhjDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"),
                                    previewLink: "", infoLink: "", subtitle: nil))
    ])
    func fetchStaticBooks() async throws -> Books {
        let books = type(of: self).books
        return books
    }
    
}
