//
//  MainCoordinator.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//

import Swinject
import RealmSwift
/// Координатор
public final class MainCoordinator: BaseCoordinator {
    
    /// DI-контейнер
    private let container: Container
    private let navigation: Navigating
    
    /// Конфигурируем окно приложения и вызываем координатор авторизации для прохождения авторизации
    func start() {
        showToDoListsViewController()
    }
    
    /// Инициализатор.
    /// - Parameter container: Контейнер
    /// - Parameter navigation: Навигация
    public init(container: Container, navigation: Navigating) {
        self.container = container
        self.navigation = navigation
    }
    
    /// Показ экрана списков задач
    public func showToDoListsViewController() {
        let vc = container.resolve(ToDoListsViewController.self)!
        vc.delegate = self
        navigation.setViewControllers([vc], animated: true)
    }
    /// Показ экрана задач
    public func showToDoViewController(id: ObjectId) {
        let vc = container.resolve(ToDoViewController.self, argument: id)!
        vc.delegate = self
        navigation.push(vc)
    }
    /// Показ экрана добавления задачи
    public func showEditToDoViewController(id: ObjectId) {
        let vc = container.resolve(AddToDoViewController.self, argument: id)!
        vc.delegate = self
        navigation.push(vc)
    }
}

/// Обработка делегата экрана списков
extension MainCoordinator: ToDoListsViewControllerDelegate {
    func showToDoList(id: ObjectId) {
        showToDoViewController(id: id)
    }
}
/// Обработка делегата экрана задач
extension MainCoordinator: ToDoViewControllerDelegate {
    func showEditToDo(id: ObjectId) {
        showEditToDoViewController(id: id)
    }
}
/// Обработка делегата экрана добавления задачи
extension MainCoordinator: AddToDoViewControllerDelegate {
    func closeScreen() {
        navigation.pop()
    }
}
