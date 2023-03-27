//
//  Books.swift
//  BookApp
//
//  Created by Julia on 2023/03/08.
//

import Foundation

// MARK: - SearchBookResponse
struct SearchBookResponse: Decodable {
    typealias BookItem = Item
    
    let totalItems: Int
    let items: [BookItem]?
    
    // MARK: - Item
    struct Item: Decodable {
        typealias BookInfo = VolumeInfo

        let volumeInfo: BookInfo
        
        // MARK: - VolumeInfo
        struct VolumeInfo: Decodable {
            let title: String
            let authors: [String]?
            let publisher, description: String?
            let pageCount: Int?
            let categories: [String]?
            let imageLinks: ImageLinks?
            let publishedDate: String?
            
            // MARK: - ImageLinks
            struct ImageLinks: Decodable {
                let smallThumbnail, thumbnail: String
            }

        }
    }
}





