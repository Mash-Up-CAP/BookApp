//
//  SearchBookRequest.swift
//  BookApp
//
//  Created by Julia on 2023/03/13.
//

import Foundation

struct SearchBookRequest: Request {
    typealias Output = SearchBookResponse
    
    var method: HTTPMethod = .get
    
    var query: QueryItems {
        ["q": q,
         "startIndex": startIndex,
         "maxResults": "\(maxResults)",
         "key": "AIzaSyDyQ-vK2AH9gIJwRzBjkdpvHbIgiIxIL8M"]
    }
    
    private let q: String
    private let startIndex: String
    private let maxResults: Int = 10
    
    init(q: String, startIndex: String) {
        self.q = q
        self.startIndex = startIndex
    }
    
}
