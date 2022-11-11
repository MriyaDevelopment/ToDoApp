//
//  MainAssembly.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//

import UIKit
import Swinject
import RealmSwift

/// Регистрация зависимостей в экранах блока Main
struct MainAssembly: Assembly {
    
    /// Регистрация компонентов в контейнер
    /// - Parameter container: DI-контейнер
    func assemble(container: Container) {
        preRegisterComponents(container: container)
        registerViewControllers(container: container)
    }
    /// Предварительная регистрация обьектов в контейнер
    /// - Parameter container: DI-контейнер
    public func preRegisterComponents(container: Container) {
        container.register(MainStorable.self) { _ in 
            StorageManager()
        }
    }
    /// Регистрация контроллеров в контейнер
    /// - Parameter container: DI-контейнер
    public func registerViewControllers(container: Container) {

        container.register(ToDoListsViewController.self) { resolver in
            let storage = resolver.resolve(MainStorable.self)!
            let config = ToDoListsBuilder.Config(storage: storage)
            return ToDoListsBuilder(config).build()
        }
        
        container.register(ToDoViewController.self) { (resolver, id: ObjectId) in
            let storage = resolver.resolve(MainStorable.self)!
            let config = ToDoBuilder.Config(storage: storage, id: id)
            return ToDoBuilder(config).build()
        }
        
        container.register(AddToDoViewController.self) { (resolver, id: ObjectId) in
            let storage = resolver.resolve(MainStorable.self)!
            let config = AddToDoBuilder.Config(storage: storage, id: id)
            return AddToDoBuilder(config).build()
        }
    }
}
