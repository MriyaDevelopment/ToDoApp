//
//  ToDoInteractor.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

protocol ToDoBusinessLogic: AnyObject {
    func initial()
    func addObject(_ item: ToDoItem)
    func deleteObject(_ index: Int)
    func toggleObject(_ item: ToDoItem)
}

/// Интерактор экрана списка задач
final class ToDoInteractor: ToDoBusinessLogic {
    
    private let presenter: ToDoPresentationLogic
    private let storage: MainStorable
    private var id: ObjectId
    private var notificationToken: NotificationToken?
    
    init(presenter: ToDoPresentationLogic, storage: MainStorable, id: ObjectId) {
        self.presenter = presenter
        self.storage = storage
        self.id = id
    }
    
    /// Функция первоначального состояния экрана при инициализации VC
    func initial() {
        let list = storage.getListById(id)
        let item = list.tasks.sorted(byKeyPath: "isCompleted")
        notificationToken = item.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(let items):
                let allCount = items.count
                let completedCount = items.filter { $0.isCompleted }.count
                self.presenter.present(state: .showEmptyState(items.isEmpty))
                self.presenter.present(state: .updateTitle(allCount, completedCount))
                self.presenter.present(items: items)
            case .update(let items, let deletions, let insertions, let updates):
                let allCount = items.count
                let completedCount = items.filter { $0.isCompleted }.count
                if items.isEmpty && deletions.count == 1 {
                    self.presenter.present(state: .showEmptyState(true))
                } else if items.count == 1 && insertions.count == 1 {
                    self.presenter.present(state: .showEmptyState(false))
                }
                self.presenter.present(state: .updateTitle(allCount, completedCount))
                self.presenter.present(updatedItems: items, deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }
    }
    /// Функция добавления новой задачи в локальную БД
    /// - Parameter item: Список задач
    func addObject(_ item: ToDoItem) {
        storage.saveTask(id, item)
    }
    /// Функция удаления задачи
    /// - Parameter item: Список задач
    func deleteObject(_ index: Int) {
        storage.deleteTask(id, index)
    }
    /// Функция изменения состояния задачи на статус "Выполнено"
    /// - Parameter item: Список задач
    func toggleObject(_ item: ToDoItem) {
        storage.toggleTask(item)
    }
}
