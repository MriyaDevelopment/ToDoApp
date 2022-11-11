//
//  AddToDoBuilder.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import RealmSwift
/// Билдер для экрана добавления задачи
final class AddToDoBuilder {

    struct Config {
        let storage: MainStorable
        let id: ObjectId
    }

    let config: Config

    public init(_ config: Config) {
        self.config = config
    }
    /// Функция создания экрана
    func build() -> AddToDoViewController {
        let presenter = AddToDoPresenter()

        let interactor = AddToDoInteractor(
            presenter: presenter,
            storage: config.storage,
            id: config.id
        )
        let controller = AddToDoViewController(
            interactor: interactor
        )
        presenter.viewController = controller
        return controller
    }
}
