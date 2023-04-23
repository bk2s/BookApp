//
//  Router.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import Foundation
import SwiftUI
import Swinject

protocol RouterProtocol {
    func configureNavigationController()
    func bookDetails(id: Int)
    func dismiss(animated: Bool)
    func back(animated: Bool)
}

class Router: RouterProtocol {
        
    private var navigationController: UINavigationController?
    
    init() {}
    
    func configureNavigationController() {
        if navigationController == nil {
            let vc = UIHostingController(rootView: SplashScreenView())
            navigationController = UINavigationController(rootViewController: vc)
            navigationController?.title = ""
            self.navigationController?.navigationBar.topItem?.hidesBackButton = true

            UIApplication.shared.windows.first?.rootViewController = navigationController
        }
    }
    
    func showMainScreen() {
        let viewModel = Container.shared.resolve(MainViewModel.self)!
        let vc = UIHostingController(rootView: MainView(viewModel: viewModel))
        navigationController = UINavigationController(rootViewController: vc)
        navigationController?.title = ""
        UIApplication.shared.windows.first?.rootViewController = navigationController
    }
    
    func bookDetails(id: Int) {
        let viewModel = Container.shared.resolve(BookDetailsViewModel.self)!
        let vc = UIHostingController(rootView: BookDetailsView(viewModel: viewModel, selectedBook: id))
        self.navigationController?.navigationBar.topItem?.hidesBackButton = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss(animated: Bool = true) {
        self.navigationController?.dismiss(animated: animated)
    }

    func back(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
}

class RouterMock: RouterProtocol {
    func configureNavigationController() {}
    func bookDetails(id: Int) {}
    func dismiss(animated: Bool = true) {}
    func back(animated: Bool = true) {}
}
