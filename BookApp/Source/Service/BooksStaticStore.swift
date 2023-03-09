//
//  BooksStaticStore.swift
//  BookApp
//
//  Created by Julia on 2023/03/08.
//

import Foundation

final class BooksStaticStore: BooksStoreProtocol {
    static let books: Books = Books(items: [
        Book(volumeInfo: VolumeInfo(title: "book1", authors: ["author1", "author1"], publisher: "가나다라", publishedDate: "2022-12-33",
                                    description: "ble. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic word", pageCount: 2, categories: ["호호", "키키"], contentVersion: "",
                                    imageLinks: ImageLinks(thumbnail: "http://books.google.com/books/content?id=otbYDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"),
                                    previewLink: "", infoLink: "", subtitle: nil)),
        Book(volumeInfo: VolumeInfo(title: "book22", authors: ["author22"], publisher: "바다라가", publishedDate: "2020-33-22",
                                    description: "Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theo", pageCount: 233, categories: ["영화", "밥"], contentVersion: "",
                                    imageLinks: ImageLinks(thumbnail: "http://books.google.com/books/content?id=jrhjDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"),
                                    previewLink: "", infoLink: "", subtitle: nil))
    ])
    func fetchStaticBooks() async throws -> Books {
        let books = type(of: self).books
        return books
    }
    
}
