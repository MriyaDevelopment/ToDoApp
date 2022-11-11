//
//  Coordinator.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//

import UIKit

public protocol Coordinator {
    /// Контроллер навигации
    var navigationController: UINavigationController { get }
}
