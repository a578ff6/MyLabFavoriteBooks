//
//  Book.swift
//  MyLabFavoriteBooks
//
//  Created by 曹家瑋 on 2023/10/9.
//

import Foundation

struct Book: CustomStringConvertible {
    let title: String
    let author: String
    let genre: String
    let length: String
    
    var description: String {
        return "\(title) 是由 \(author) 所寫，屬於 \(genre) 類型，並且有 \(length) 頁。"
    }
}
