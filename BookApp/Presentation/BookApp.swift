//
//  BookApp.swift
//  Book
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import SwiftUI
import Firebase
import Swinject

@main
struct BookApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView()
                .onAppear {
                    Container.shared.resolve(Router.self)!.configureNavigationController()
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        _ = Assembler([AppAssembly()],container: Container.shared)
        Theme.Fonts.registerFonts()

        return true
    }
}
