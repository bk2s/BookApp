//
//  SummaryView.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import SwiftUI

struct SummaryView: View {
    
    enum SummuryType {
        case readers
        case likes
        case quotes
        case genre
        
        var localization: String {
            switch self {
            case .readers:
                return AppLocalization.Details.readers
            case .likes:
                return AppLocalization.Details.likes
            case .quotes:
                return AppLocalization.Details.quotes
            case .genre:
                return AppLocalization.Details.genre
            }
        }
    }
    
    private let type: SummuryType
    private let interactions: String
    
    init(type: SummuryType, interactions: String) {
        self.type = type
        self.interactions = interactions
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(interactions)
                    .foregroundColor(.black)
                    .font(Theme.Fonts.displayMedium)
                if interactions == "Hot" {
                    AppAssets.hot.swiftUIImage
                }
            }
            Text(type.localization)
                .foregroundColor(.gray)
                .font(Theme.Fonts.bodySmall)
            
        }
    }
}
