//
//  ToDoItem.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

/// Realm Object задачи
public class ToDoItem: Object {
    /// Primary key
    @Persisted(primaryKey: true) var _id: ObjectId
    /// Название задачи
    @Persisted var note = ""
    /// Флаг выполнения задачи
    @Persisted var isCompleted = false
    
    /// Инициализатор.
    /// - Parameter note: Название задачи
    /// - Parameter isCompleted: Флаг выполнения задачи
    convenience init(note: String, isCompleted: Bool = false) {
        self.init()
        self.note = note
        self.isCompleted = isCompleted
    }
}
