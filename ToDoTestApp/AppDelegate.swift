//
//  AppDelegate.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//

import Swinject
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    private var resolver: Resolver!
    private var appCoordinator: ApplicationCoordinator!
    
    /// Инициализируем резолвер для Swinject
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        resolver = Assembler.sharedAssembler.resolver
        return true
    }

    /// Запускаем флоу приложения
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigation()
        return true
    }
}

extension AppDelegate {
    
    /// Функция конфигурирует и инициализирует навигацию в приложении
    private func setupNavigation() {
        window = UIWindow()
        appCoordinator = resolver.resolve(ApplicationCoordinator.self)
        appCoordinator.window = window
        appCoordinator.start()
        
        window?.makeKeyAndVisible()
    }
}

