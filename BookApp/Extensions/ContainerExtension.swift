//
//  ContainerExtension.swift
//  BookApp
//
//  Created by  Stepanok Ivan on 22.04.2023.
//

import Foundation
import Swinject

extension Container {
    static var shared: Container = {
        let container = Container()
        return container
    }()
}
