//
//  ToDoBuilder.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import RealmSwift
/// Билдер для экрана списка задач
final class ToDoBuilder {

    struct Config {
        let storage: MainStorable
        let id: ObjectId
    }

    let config: Config

    public init(_ config: Config) {
        self.config = config
    }
    /// Функция создания экрана
    func build() -> ToDoViewController {
        let presenter = ToDoPresenter()

        let interactor = ToDoInteractor(
            presenter: presenter,
            storage: config.storage,
            id: config.id
        )
        let controller = ToDoViewController(
            interactor: interactor,
            listId: config.id
        )
        presenter.viewController = controller
        return controller
    }
}
