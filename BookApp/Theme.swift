//
//  Theme.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import Foundation
import SwiftUI

public struct Theme {
    
    public struct Fonts {
        public static let displayMedium: Font = .custom("NunitoSans-Bold", size: 20)
        public static let displayLarge: Font = .custom("NunitoSans-Bold", size: 52)
        public static let bodyMedium: Font = .custom("NunitoSans-SemiBold", size: 16)
        public static let bodySmall: Font = .custom("NunitoSans-SemiBold", size: 12)

    }
}

public extension Theme.Fonts {
    // swiftlint: disable type_name
    class __ {}
    static func registerFonts() {
        guard let url = Bundle(for: __.self).url(forResource: "NunitoSans-Bold", withExtension: "ttf") else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }
}

extension View {
    public func loadFonts() -> some View {
        Theme.Fonts.registerFonts()
        return self
    }
}
