//
//  BooksResponse.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import Foundation

// MARK: - BooksResponse
struct BooksResponse: Codable {
    let books: [BookResponse]

    init(books: [BookResponse]) {
        self.books = books
    }
}

// MARK: - Book
struct BookResponse: Codable {
    let id: Int
    let name: String
    let author: String
    let summary: String
    let genre: String
    let coverURL: String
    let views: String
    let likes: String
    let quotes: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case author = "author"
        case summary = "summary"
        case genre = "genre"
        case coverURL = "cover_url"
        case views = "views"
        case likes = "likes"
        case quotes = "quotes"
    }

    init(id: Int,
         name: String,
         author: String,
         summary: String,
         genre: String,
         coverURL: String,
         views: String,
         likes: String,
         quotes: String) {
        self.id = id
        self.name = name
        self.author = author
        self.summary = summary
        self.genre = genre
        self.coverURL = coverURL
        self.views = views
        self.likes = likes
        self.quotes = quotes
    }
}

extension BooksResponse {
    var domain: [BookModel] {
        books.map {
            BookModel(id: $0.id,
                      name: $0.name,
                      author: $0.author,
                      summary: $0.summary,
                      genre: $0.genre,
                      coverURL: $0.coverURL,
                      views: $0.views,
                      likes: $0.likes,
                      quotes: $0.quotes)
        }
    }
}
