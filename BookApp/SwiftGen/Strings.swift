// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum AppLocalization {
  public enum Details {
    /// You will also like
    public static let alsoLike = AppLocalization.tr("Localizable", "DETAILS.ALSO_LIKE", fallback: "You will also like")
    /// Genre
    public static let genre = AppLocalization.tr("Localizable", "DETAILS.GENRE", fallback: "Genre")
    /// Likes
    public static let likes = AppLocalization.tr("Localizable", "DETAILS.LIKES", fallback: "Likes")
    /// Quotes
    public static let quotes = AppLocalization.tr("Localizable", "DETAILS.QUOTES", fallback: "Quotes")
    /// Readers
    public static let readers = AppLocalization.tr("Localizable", "DETAILS.READERS", fallback: "Readers")
  }
  public enum MainView {
    /// Library
    public static let library = AppLocalization.tr("Localizable", "MAIN_VIEW.LIBRARY", fallback: "Library")
  }
  public enum SplashScreen {
    /// Localizable.strings
    ///   Book
    /// 
    ///   Created by  Stepanok Ivan on 22.04.2023.
    public static let name = AppLocalization.tr("Localizable", "SPLASH_SCREEN.NAME", fallback: "Book App")
    /// Welcome to Book App
    public static let welcome = AppLocalization.tr("Localizable", "SPLASH_SCREEN.WELCOME", fallback: "Welcome to Book App")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension AppLocalization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
