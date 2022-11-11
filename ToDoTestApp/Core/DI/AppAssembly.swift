//
//  AppAssembly.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//
import Swinject
/// Регистрация компонентов в приложении
struct AppAssembly: Assembly {
    
    /// Регистрация компонентов в контейнер
    /// - Parameter container: DI-контейнер
    func assemble(container: Container) {
        registerNavigation(container: container)
        registerCoordinators(container: container)
    }
    
    /// Регситрация навигации
    /// - Parameter container: DI-контейнер
    private func registerNavigation(container: Container) {
        container.register(Navigating.self) { _ in
            let navigationController = UINavigationController()
            return Navigation(navigationController: navigationController)
        }
    }
    
    /// Регистрация координаторов
    /// - Parameter container: DI-контейнер
    private func registerCoordinators(container: Container) {
        let navigation = container.resolve(Navigating.self)!
        
        container.register(ApplicationCoordinator.self) { _ in
            ApplicationCoordinator(container: container, navigation: navigation)
        }
        
        container.register(MainCoordinator.self) { _ in
            MainCoordinator(container: container, navigation: navigation)
        }
    }
}
