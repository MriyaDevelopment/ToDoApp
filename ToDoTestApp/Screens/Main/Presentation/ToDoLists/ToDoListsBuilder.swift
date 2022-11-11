//
//  ToDoListsBuilder.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import RealmSwift
/// Билдер для экрана списков задач
final class ToDoListsBuilder {

    struct Config {
        let storage: MainStorable
    }

    let config: Config

    public init(_ config: Config) {
        self.config = config
    }
    /// Функция создания экрана
    func build() -> ToDoListsViewController {
        let presenter = ToDoListsPresenter()

        let interactor = ToDoListsInteractor(
            presenter: presenter,
            storage: config.storage
        )
        let controller = ToDoListsViewController(
            interactor: interactor
        )
        presenter.viewController = controller
        return controller
    }
}
