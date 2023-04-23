//
//  MainViewModel.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import Foundation
import SwiftUI
import Firebase

class MainViewModel: ObservableObject {
    
    private let firebaseManager: FirebaseManagerProtocol
    private let localDataManager: LocalDataManagerProtocol
    public let router: RouterProtocol
    
    @Published var banners: [TopBanner] = []
    var books: [BookModel] = []
    @Published var genres: [String] = []
    @Published private(set) var stateModel: UIStateModel = UIStateModel()
    
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
        
        loadTopBanners()
        loadBooks()
    }
    
    private func loadTopBanners() {
        isLoading = true
        Task {
            do {
                self.banners = try await localDataManager.getBanners()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation {
                        self.isLoading = false
                    }
                    self.errorMessage = "Demo error message"
                }
            } catch let error {
                errorMessage = error.localizedDescription
                isLoading = false
                Crashlytics.crashlytics().log("MainViewModel / loadTopBanners")
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
    
    private func loadBooks() {
        isLoading = true
        Task {
            do {
                self.books = try await localDataManager.getBooks()
                getGenres()
//                isLoading = false
            } catch let error {
                errorMessage = error.localizedDescription
                isLoading = false
                Crashlytics.crashlytics().log("MainViewModel / loadBooks")
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
    
    private func getGenres() {
        self.genres = Array(Set(self.books.map({ $0.genre })))
        
    }
}
