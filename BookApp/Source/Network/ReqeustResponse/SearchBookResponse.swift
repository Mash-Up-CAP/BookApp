//
//  Books.swift
//  BookApp
//
//  Created by Julia on 2023/03/08.
//

import Foundation

typealias BookInfo = VolumeInfo
 
// MARK: - SearchBookResponse
struct SearchBookResponse: Decodable {
    let kind: String
    let totalItems: Int
    let items: [Item]?
}

// MARK: - Item
struct Item: Decodable {
    let id, etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let publisher, description: String?
    let pageCount: Int?
    let categories: [String]?
    let imageLinks: ImageLinks?
    let previewLink: String
    let infoLink: String
    let publishedDate: String?
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}
