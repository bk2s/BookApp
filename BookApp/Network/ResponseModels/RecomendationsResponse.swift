//
//  RecomendationsResponse.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import Foundation

// MARK: - RecomendationsResponse
public struct RecomendationsResponse: Codable {
    public let youWillLikeSection: [Int]

    enum CodingKeys: String, CodingKey {
        case youWillLikeSection = "you_will_like_section"
    }

    public init(youWillLikeSection: [Int]) {
        self.youWillLikeSection = youWillLikeSection
    }
}
