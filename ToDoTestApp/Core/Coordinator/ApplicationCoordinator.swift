//
//  ApplicationCoordinator.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//

import Swinject
/// Разводящий координатор приложения
public final class ApplicationCoordinator: BaseCoordinator {
    /// UIWindow приложения
    public var window: UIWindow!

    /// DI-контейнер
    private let container: Container
    private let navigation: Navigating
    
    /// Установка main координатора и навигации
    func start() {
        window.rootViewController = navigation.navigationController
        let mainCoordinator = getMainCoordinator()
        mainCoordinator?.start()
    }
    
    /// Инициализатор.
    /// - Parameter container: Контейнер
    /// - Parameter navigation: Навигация
    public init(container: Container, navigation: Navigating) {
        self.container = container
        self.navigation = navigation
    }
    
    /// Получение main координатора
    func getMainCoordinator() -> MainCoordinator? {
        let mainCoordinator = getCoordinator(.main, coordinator: container.resolve(MainCoordinator.self))
        return mainCoordinator
    }
    
}
