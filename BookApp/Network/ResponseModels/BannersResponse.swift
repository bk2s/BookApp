//
//  BannerData.swift
//  Book
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import Foundation

// MARK: - BannersResponse
struct BannersResponse: Codable {
    let topBannerSlides: [TopBannerSlideResponse]
    
    enum CodingKeys: String, CodingKey {
        case topBannerSlides = "top_banner_slides"
    }
    
    init(topBannerSlides: [TopBannerSlideResponse]) {
        self.topBannerSlides = topBannerSlides
    }
}

// MARK: - TopBannerSlide
struct TopBannerSlideResponse: Codable {
    let id: Int
    let bookID: Int
    let cover: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case bookID = "book_id"
        case cover = "cover"
    }
    
    init(id: Int, bookID: Int, cover: String) {
        self.id = id
        self.bookID = bookID
        self.cover = cover
    }
}

extension BannersResponse {
    var domain: [TopBanner] {
        topBannerSlides.map { TopBanner(id: $0.id,
                                        bookID: $0.bookID,
                                        coverUrl: $0.cover)
        }
    }
}
