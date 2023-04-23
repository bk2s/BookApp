//
//  API.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import Foundation

protocol LocalDataManagerProtocol {
    func getBanners() async throws -> [TopBanner]
    func getBooks() async throws -> [BookModel]
    func getRecomendations() async throws -> [Int]
}

class LocalDataManager: LocalDataManagerProtocol {
    
    let noFileError = URLError(.cannotOpenFile)
    
    func getBanners() async throws -> [TopBanner] {
        guard let jsonURL = Bundle.main.url(forResource: "BannersData", withExtension: "json") else { throw noFileError }
            let jsonData = try Data(contentsOf: jsonURL)
            let jsonDecoder = JSONDecoder()
            let banners = try jsonDecoder.decode(BannersResponse.self, from: jsonData)
        return banners.domain
        }
    
    func getBooks() async throws -> [BookModel] {
        guard let jsonURL = Bundle.main.url(forResource: "BooksData", withExtension: "json") else { throw noFileError }
            let jsonData = try Data(contentsOf: jsonURL)
            let jsonDecoder = JSONDecoder()
            let banners = try jsonDecoder.decode(BooksResponse.self, from: jsonData)
        return banners.domain
        }
    
    func getRecomendations() async throws -> [Int] {
        guard let jsonURL = Bundle.main.url(forResource: "RecommendationsData", withExtension: "json")
        else { throw noFileError }
            let jsonData = try Data(contentsOf: jsonURL)
            let jsonDecoder = JSONDecoder()
            let banners = try jsonDecoder.decode(RecomendationsResponse.self, from: jsonData)
        return banners.youWillLikeSection
        }
}

class LocalDataManagerMock: LocalDataManagerProtocol {
    func getBanners() async throws -> [TopBanner] {
        [
            TopBanner(id: 1, bookID: 1, coverUrl: "https://i.pinimg.com/564x/9a/d6/ad/9ad6ade006446f1fa36b812c91c32184.jpg"),
            TopBanner(id: 2, bookID: 2, coverUrl: "https://i.pinimg.com/564x/d0/5c/11/d05c11aa655091c6c59efb5773c3d1cb.jpg"),
            TopBanner(id: 3, bookID: 3, coverUrl: "https://i.pinimg.com/564x/dd/8f/bf/dd8fbfed20852341fa1e4136baa31a70.jpg"),
            TopBanner(id: 3, bookID: 3, coverUrl: "https://i.pinimg.com/564x/42/fb/6c/42fb6cc4a9eeb836bd6dde4eccf694fe.jpg"),
            TopBanner(id: 3, bookID: 3, coverUrl: "https://i.pinimg.com/564x/12/0d/fd/120dfde0de5b8dcaf4d461168c8ba72d.jpg")
        ]
    }
    
    func getBooks() async throws -> [BookModel] {
        [
        BookModel(id: 1, name: "Just Friends",
                         author: "Author",
                         summary: "Summury",
                         genre: "Hot",
                         coverURL: "https://i.pinimg.com/564x/2f/f5/7e/2ff57ee708d4f86b2ce8a7f4758e7dd7.jpg",
                         views: "Views",
                         likes: "Likes",
                         quotes: "Quotes"),
        BookModel(id: 2, name: "The void in your eyes",
                         author: "Author 2",
                         summary: "Summury 2",
                         genre: "Romance",
                         coverURL: "https://i.pinimg.com/564x/1d/c3/35/1dc335d3123bf446b0ab0b358554629e.jpg",
                         views: "Views",
                         likes: "Likes",
                         quotes: "Quotes"),
        BookModel(id: 3, name: "Last Year's mistake",
                         author: "Author",
                         summary: "Summury",
                         genre: "Romance",
                         coverURL: "https://i.pinimg.com/564x/f3/e1/68/f3e1685ecc142f0143d6f28b9a77a6b5.jpg",
                         views: "Views",
                         likes: "Likes",
                         quotes: "Quotes"),
        BookModel(id: 4, name: "Inesistible",
                         author: "Author 2",
                         summary: "Summury 2",
                         genre: "Romance",
                         coverURL: "https://i.pinimg.com/564x/54/cd/6c/54cd6ce988ca8e62079d6c3c81024efa.jpg",
                         views: "Views",
                         likes: "Likes",
                         quotes: "Quotes"),
        BookModel(id: 5, name: "Never load a cover at the night",
                         author: "Author",
                         summary: "Summury",
                         genre: "Genre",
                         coverURL: "https://i.pinimg.com/564x/d8/61/1e/d8611eadbf839ef4d9c86209cd88649e.jpg.jpg",
                         views: "Views",
                         likes: "Likes",
                         quotes: "Quotes"),
        BookModel(id: 6, name: "Through my window",
                         author: "Author 2",
                         summary: "Summury 2",
                         genre: "Genre 2",
                         coverURL: "https://i.pinimg.com/564x/c1/52/98/c1529833694a4564247b1afdd2bf2e9a.jpg",
                         views: "Views",
                         likes: "Likes",
                         quotes: "Quotes")
        ]
    }
    
    func getRecomendations() async throws -> [Int] {
        [1, 2, 3]
    }
}
