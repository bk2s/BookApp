//
//  BookApp.swift
//  Book
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import SwiftUI

@main
struct BookApp: App {
    
    let manager = FirebaseManager()
    
    var body: some Scene {
        WindowGroup {
            MainView(manager: manager)
        }
    }
}
