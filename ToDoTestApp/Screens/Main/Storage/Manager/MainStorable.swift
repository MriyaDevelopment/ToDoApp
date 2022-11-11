//
//  MainStorable.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//

import Foundation
import RealmSwift

/// Протокол для работы с менеджером локальной БД
protocol MainStorable {
    func getAllLists() -> Results<ToDoListItem>
    func getListById(_ id: ObjectId) -> ToDoListItem
    func saveList(_ item: ToDoListItem)
    func deleteList(_ item: ToDoListItem)
    func saveTask(_ id: ObjectId, _ item: ToDoItem)
    func deleteTask(_ id: ObjectId, _ index: Int)
    func toggleTask(_ item: ToDoItem)
}

/// Менеджер локальной БД
final class StorageManager: MainStorable {
    
    let realm = try! Realm()
    /// Получение всех имеющихся списков задач
    func getAllLists() -> Results<ToDoListItem> {
        return realm.objects(ToDoListItem.self)
    }
    /// Получение списка по id
    func getListById(_ id: ObjectId) -> ToDoListItem {
        guard let item = realm.object(ofType: ToDoListItem.self, forPrimaryKey: id) else { return ToDoListItem() }
        return item
    }
    /// Сохранение нового списка
    func saveList(_ item: ToDoListItem) {
        realm.writeAsync {
            self.realm.add(item)
        }
    }
    /// Удаление списка
    func deleteList(_ item: ToDoListItem) {
        realm.writeAsync {
            self.realm.delete(item)
        }
    }
    ///Сохранение задачи
    func saveTask(_ id: ObjectId, _ item: ToDoItem) {
        let list = getListById(id)
        realm.writeAsync {
            list.tasks.append(item)
        }
    }
    ///Удаление задачи
    func deleteTask(_ id: ObjectId, _ index: Int) {
        let list = getListById(id)
        realm.writeAsync {
            self.realm.delete(list.tasks[index])
        }
    }
    ///Выставление задачи в статус "Выполнено"
    func toggleTask(_ item: ToDoItem) {
        realm.writeAsync {
            item.isCompleted.toggle()
        }
    }
}

