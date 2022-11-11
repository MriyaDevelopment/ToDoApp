//
//  BaseCoordinator.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation

/// Типы координаторов в приложении
///
/// - main: MainCoordinator
public enum Coordinators: String {
    case main
}

/// Базовый координатор
open class BaseCoordinator: NSObject {
    
    public override init() { }
    
    /// Дочерние коодинаторы
    private var childCoordinators: [String: BaseCoordinator] = [:]

    /// Функция получает возвращает координатор, создавая новый экземпляр координатора
    /// или уже зарегистрированный в childCoordinators
    /// - Parameters:
    ///   - coordinators: типа координаторов
    ///   - coordinator: экземпляр координатора
    open func getCoordinator<T>(_ coordinators: String, coordinator: T?) -> T? {
        guard let coordinator = coordinator as? BaseCoordinator else {
            return .none
        }
        
        if childCoordinators.contains(where: { $0.key == coordinators }) {
            return childCoordinators[coordinators] as? T
        }
        
        childCoordinators[coordinators] = coordinator
        return coordinator as? T
    }
    
    /// Функция получает возвращает координатор, создавая новый экземпляр координатора
    /// или уже зарегистрированный в childCoordinators
    /// - Parameters:
    ///   - coordinators: название координатора
    ///   - coordinator: экземпляр координатора
    open func getCoordinator<T>(_ coordinators: Coordinators, coordinator: T?) -> T? {
        getCoordinator(coordinators.rawValue, coordinator: coordinator)
    }
    
    /// Функция удаляет  координатор и его дочерние координаторы
    /// - Parameter coordinators: название координатора
    open func removeCoordinator(_ coordinators: String) {
        guard
            !childCoordinators.isEmpty else {
                return
        }
        
        // Рекурсивно удаляем все дочерные координаторы
        if let coordinator = childCoordinators[coordinators], !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0.value !== coordinator })
                .forEach({ coordinator.removeCoordinator($0.key) })
        }
        
        childCoordinators[coordinators] = nil
    }
    
    /// Функция удаляет  координатор и его дочерние координаторы
    /// - Parameter coordinators: тип координатора
    open func removeCoordinator(_ coordinators: Coordinators) {
        removeCoordinator(coordinators.rawValue)
    }
}
