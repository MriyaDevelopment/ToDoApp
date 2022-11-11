//
//  AddToDoInteractor.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

protocol AddToDoBusinessLogic: AnyObject {
    func initial()
    func addObject(_ item: ToDoItem)
}

/// Интерактор экрана добавления задачи
final class AddToDoInteractor: AddToDoBusinessLogic {
    
    private let presenter: AddToDoPresentationLogic
    private let storage: MainStorable
    private var id: ObjectId
    private var notificationToken: NotificationToken?
    
    init(presenter: AddToDoPresentationLogic, storage: MainStorable, id: ObjectId) {
        self.presenter = presenter
        self.storage = storage
        self.id = id
    }
    
    /// Функция первоначального состояния экрана при инициализации VC
    func initial() {
        let list = storage.getListById(id)
        let item = list.tasks
        notificationToken = item.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .update(_, _, _, _):
                self.presenter.present(state: .updateSuccess)
            case .error: break
            default: break
            }
        }
    }
    
    func addObject(_ item: ToDoItem) {
        storage.saveTask(id, item)
    }
}
