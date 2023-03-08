//
//  Book.swift
//  BookApp
//
//  Created by Julia on 2023/03/08.
//

import Foundation

typealias Book = Item

struct Books: Decodable {
    let items: [Book]
}

// MARK: - Item
struct Item: Decodable {
    let volumeInfo: VolumeInfo
}

// MARK: - VolumeInfo
struct VolumeInfo: Decodable {
    let title: String
    let authors: [String]
    let publisher: String?
    let publishedDate: String
    let description: String?
    let pageCount: Int
    let categories: [String]?
    let contentVersion: String
    let imageLinks: ImageLinks?
    let previewLink: String
    let infoLink: String
    let subtitle: String?
}

// MARK: - ImageLinks
struct ImageLinks: Decodable {
    let thumbnail: String
}

// MARK: - StaticBookModel
struct StaticBookModel {
    let title: String
    let author: String
    let publishedDate: String
}
