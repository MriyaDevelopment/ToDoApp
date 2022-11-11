//
//  ToDoListsInteractor.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

protocol ToDoListsBusinessLogic: AnyObject {
    func initial()
    func addObject(_ item: ToDoListItem)
    func deleteObject(_ item: ToDoListItem)
}

/// Интерактор экрана списков задач
final class ToDoListsInteractor: ToDoListsBusinessLogic {
    
    private let presenter: ToDoListsPresentationLogic
    private let storage: MainStorable
    private var notificationToken: NotificationToken?
    
    init(presenter: ToDoListsPresentationLogic, storage: MainStorable) {
        self.presenter = presenter
        self.storage = storage
    }
    
    /// Функция первоначального состояния экрана при инициализации VC
    func initial() {
        let items = storage.getAllLists()
        notificationToken = items.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(let items):
                self.presenter.present(state: .showEmptyState(items.isEmpty))
                self.presenter.present(items: items)
            case .update(let items, let deletions, let insertions, let updates):
                if items.isEmpty && deletions.count == 1 {
                    self.presenter.present(state: .showEmptyState(true))
                } else if items.count == 1 && insertions.count == 1 {
                    self.presenter.present(state: .showEmptyState(false))
                }
                self.presenter.present(updatedItems: items, deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }
    }
    
    /// Функция добавления нового списка в локальную БД
    /// - Parameter item: Список задач
    func addObject(_ item: ToDoListItem) {
        storage.saveList(item)
    }
    /// Функция удаления списка из локальной БД
    /// - Parameter item: Список задач
    func deleteObject(_ item: ToDoListItem) {
        storage.deleteList(item)
    }
}
