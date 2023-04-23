//
//  ScreenAssembly.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import Foundation
import Swinject

class AppAssembly: Assembly {
    func assemble(container: Container) {
        
        // MARK: - Managers
        container.register(FirebaseManager.self, factory: { _ in
            FirebaseManager()
        })
        
        container.register(LocalDataManager.self, factory: { _ in
            LocalDataManager()
        })
        
        container.register(Router.self, factory: { _ in
            Router()
        }).inObjectScope(.container)
        
        // MARK: - ViewModels
        container.register(MainViewModel.self, factory: { r in
            MainViewModel(firebaseManager: r.resolve(FirebaseManager.self)!,
                          localDataManager: r.resolve(LocalDataManager.self)!,
                          router: r.resolve(Router.self)!)
        })
        
        container.register(BookDetailsViewModel.self, factory: { r in
            BookDetailsViewModel(firebaseManager: r.resolve(FirebaseManager.self)!,
                                 localDataManager: r.resolve(LocalDataManager.self)!,
                                 router: r.resolve(Router.self)!)
        })
    }
}
