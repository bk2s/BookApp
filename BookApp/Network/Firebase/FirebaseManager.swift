//
//  FirebaseManager.swift
//  Book
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol FirebaseManagerProtocol {
    func getJson() async
    func getTopBannerSlides() async -> [TopBannerSlide]
    func getDetailsCarouselBooks() async -> [Book]
    func getYouWillLikeBooks() async -> [Book]
}

class FirebaseManager: FirebaseManagerProtocol {
    
    let db: Firestore
    
    init() {
        self.db = Firestore.firestore()
    }
    
    func getJson() async {
        do {
            let data = try await db.collection("json_data").getDocuments()
            print(">>>>", data)
        } catch {
            Crashlytics.crashlytics().log("FirebaseManager / getJson")
            Crashlytics.crashlytics().record(error: error)
        }
    }
    
    func getTopBannerSlides() async -> [TopBannerSlide] {
        do {
            let snapshot = try await db.collection("top_banner_slides").getDocuments()
            let slides = snapshot.documents.compactMap { TopBannerSlide(json: $0.data()) }
            return slides
        } catch {
            print("Error getting top banner slides: \(error.localizedDescription)")
            Crashlytics.crashlytics().log("FirebaseManager / getTopBannerSlides")
            Crashlytics.crashlytics().record(error: error)
            return []
        }
    }
    
    func getDetailsCarouselBooks() async -> [Book] {
        do {
            let snapshot = try await db.collection("details_carousel").getDocuments()
            let books = snapshot.documents.compactMap { Book(json: $0.data()) }
            return books
        } catch {
            print("Error getting details carousel books: \(error.localizedDescription)")
            Crashlytics.crashlytics().log("FirebaseManager / getDetailsCarouselBooks")
            Crashlytics.crashlytics().record(error: error)
            return []
        }
    }
    
    func getYouWillLikeBooks() async -> [Book] {
        do {
            let snapshot = try await db.collection("you_will_like_section").getDocuments()
            let books = snapshot.documents.compactMap { Book(id: $0.documentID,
                                                             recommendation: "You will also like",
                                                             json: $0.data()) }
            return books
        } catch {
            print("Error getting you will like books: \(error.localizedDescription)")
            Crashlytics.crashlytics().log("FirebaseManager / getYouWillLikeBooks")
            Crashlytics.crashlytics().record(error: error)
            return []
        }
    }
}

class FirebaseManagerMock: FirebaseManagerProtocol {
    func getJson() async {}
    func getTopBannerSlides() async -> [TopBannerSlide] {[]}
    func getDetailsCarouselBooks() async -> [Book] {[]}
    func getYouWillLikeBooks() async -> [Book] {[]}
}

struct TopBannerSlide {
    let imageUrl: String
    let bookId: String
    
    init?(json: [String: Any]) {
        guard let imageUrl = json["image_url"] as? String,
                let bookId = json["book_id"] as? String else { return nil }
        self.imageUrl = imageUrl
        self.bookId = bookId
    }
}

struct Book {
    let id: String
    let title: String
    let author: String
    let coverImageUrl: String
    let recommendation: String
    
    init?(json: [String: Any]) {
        guard let title = json["title"] as? String,
                let author = json["author"] as? String,
                let coverImageUrl = json["cover_image_url"] as? String else { return nil }
        self.id = ""
        self.title = title
        self.author = author
        self.coverImageUrl = coverImageUrl
        self.recommendation = ""
    }
    
    init(id: String, title: String = "", author: String = "", coverImageUrl: String = "", recommendation: String) {
        self.id = id
        self.title = title
        self.author = author
        self.coverImageUrl = coverImageUrl
        self.recommendation = recommendation
    }
    
    init?(id: String, recommendation: String, json: [String: Any]) {
        guard let title = json["title"] as? String,
                let author = json["author"] as? String,
                let coverImageUrl = json["cover_image_url"] as? String else { return nil }
        self.id = id
        self.title = title
        self.author = author
        self.coverImageUrl = coverImageUrl
        self.recommendation = recommendation
    }
}
