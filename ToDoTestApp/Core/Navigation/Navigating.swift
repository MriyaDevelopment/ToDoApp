//
//  Navigating.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//

import UIKit

public protocol Navigating: Coordinator {
    
    /// Контроллер меню верхнего уровня
    var navigationController: UINavigationController { get }

    /// Push ViewController
    /// - Parameter viewController: viewController
    func push(_ viewController: UIViewController)
    
    /// Push ViewController
    /// - Parameters:
    ///   - viewController: viewController
    ///   - animated: включение анимации
    func push(_ viewController: UIViewController, animated: Bool)
    
    /// Present ViewController
    /// - Parameter viewController: ViewController
    func present(_ viewController: UIViewController)
    
    /// Present ViewController
    /// - Parameters:
    ///   - viewController: viewController
    ///   - animated: включение анимации
    ///   - completion: доп. действия
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    /// Переходим к рутовому ViewController'у
    func popToRoot()
    
    /// Переходим к рутовому ViewController'у
    /// - Parameter animated: включение анимации
    func popToRoot(animated: Bool)
    
    /// Поднять ViewController наверх в стэке
    /// - Parameter viewController: viewController
    func popTo(_ viewController: UIViewController)
    
    /// Gоднять ViewController наверх в стэке
    /// - Parameters:
    ///   - viewController: viewController
    ///   - animated: включение анимации
    func popTo(_ viewController: UIViewController, animated: Bool)
    
    /// Удалить топовый ViewController из стека
    /// - Parameters:
    ///   - animated: включение анимации
    func pop()
    
    /// Удалить топовый ViewController из стека
    /// - Parameters:
    ///   - animated: включение анимации
    ///   - completion: доп. действия
    func pop(animated: Bool, completion: (() -> Void)?)
    
    /// Завершение экрана
    func dismiss()
    
    /// Завершение последнего экрана в стэке
    /// - Parameters:
    ///   - animated: включение анимации
    ///   - completion: доп. действия
    func dismiss(animated: Bool, completion: (() -> Void)?)
    
    /// Заполняем стэк новыми ViewController заменяя старые
    /// - Parameters:
    ///   - viewControllers: viewController'ы
    ///   - animated: включение анимации
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    
}

public final class Navigation: NSObject, Navigating {
    
    /// Контроллер навигации
    public let navigationController: UINavigationController

    /// Создаёт класс навигации, основанный на навигационном стеке (без меню верхнего уровня)
    /// - Parameter navigationController: контроллер навигации
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    /// Push ViewController
    /// - Parameter viewController: viewController
    public func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }
    
    /// Push ViewController
    /// - Parameters:
    ///   - viewController: viewController
    ///   - animated: включение анимации
    public func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    /// Present ViewController
    /// - Parameter viewController: ViewController
    public func present(_ viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    /// Present ViewController
    /// - Parameters:
    ///   - viewController: viewController
    ///   - animated: включение анимации
    ///   - completion: доп. действия
    public func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        
        if let presentedController = navigationController.presentedViewController {
            presentedController.present(viewController, animated: true, completion: completion)
            return
        }
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    /// Переходим к рутовому ViewController'у
    public func popToRoot() {
        popToRoot(animated: true)
    }
    
    /// Переходим к рутовому ViewController'у
    /// - Parameter animated: включение анимации
    public func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    /// Поднять ViewController наверх в стэке
    /// - Parameter viewController: viewController
    public func popTo(_ viewController: UIViewController) {
        popTo(viewController, animated: true)
    }
    
    /// Gоднять ViewController наверх в стэке
    /// - Parameters:
    ///   - viewController: viewController
    ///   - animated: включение анимации
    public func popTo(_ viewController: UIViewController, animated: Bool) {
        navigationController.popToViewController(viewController, animated: animated)
    }
    
    /// Удалить топовый ViewController из стека
    /// - Parameters:
    ///   - animated: включение анимации
    public func pop() {
        pop(animated: true, completion: nil)
    }
    
    /// Удалить топовый ViewController из стека
    /// - Parameters:
    ///   - animated: включение анимации
    ///   - completion: доп. действия
    public func pop(animated: Bool, completion: (() -> Void)?) {
        navigationController.popViewController(animated: animated)
        
        if animated, let coordinator = navigationController.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        } else {
            completion?()
        }
    }
    
    /// Завершение экрана согласно идентификатору
    /// - Parameter идентификатор
    public func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    /// Завершение последнего экрана в стэке
    /// - Parameters:
    ///   - animated: включение анимации
    ///   - completion: доп. действия
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        
        if let presentedController = navigationController.presentedViewController {
            presentedController.dismiss(animated: animated, completion: completion)
            return
        }
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    /// Заполняем стэк новыми ViewController заменяя старые
    /// - Parameters:
    ///   - viewControllers: viewController'ы
    ///   - animated: включение анимации
    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        navigationController.setViewControllers(viewControllers, animated: animated)
    }
    
}
