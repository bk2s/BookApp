//
//  BookDetailsViewModel.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 23.04.2023.
//

import Foundation
import SwiftUI
import Firebase

class BookDetailsViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseManagerProtocol
    private let localDataManager: LocalDataManagerProtocol
    public let router: RouterProtocol
    
    private var alsoLike: [Int] = []
    
    @Published var books: [BookModel] = []
    @Published var likedBooks: [BookModel] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    var errorMessage: String? {
        didSet {
            withAnimation {
                showError = errorMessage != nil
            }
        }
    }
    
    init(firebaseManager: FirebaseManagerProtocol,
         localDataManager: LocalDataManagerProtocol,
         router: RouterProtocol) {
        self.firebaseManager = firebaseManager
        self.localDataManager = localDataManager
        self.router = router
        loadBooks()
    }
    
    public func loadBooks() {
        isLoading = true
        Task {
            do {
                self.books = try await localDataManager.getBooks()
                loadAlsoLike()
                isLoading = false
            } catch let error {
                errorMessage = error.localizedDescription
                isLoading = false
                Crashlytics.crashlytics().log("BookDetailsViewModel / loadBooks")
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
    
    public func loadAlsoLike() {
        isLoading = true
        Task {
            do {
                self.alsoLike = try await localDataManager.getRecomendations()
                self.likedBooks = books.filter { alsoLike.contains($0.id) }
                isLoading = false
            } catch let error {
                errorMessage = error.localizedDescription
                isLoading = false
                Crashlytics.crashlytics().log("BookDetailsViewModel / loadAlsoLike")
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
}
