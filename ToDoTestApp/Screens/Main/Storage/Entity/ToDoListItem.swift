//
//  ToDoListItem.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

/// Realm Object списка задач
public class ToDoListItem: Object {
    /// Primary key
    @Persisted(primaryKey: true) var _id: ObjectId
    /// Название списка
    @Persisted var text = ""
    /// Массив обьектов задач
    @Persisted var tasks: List<ToDoItem>
    
    /// Инициализатор.
    /// - Parameter text: Название списка
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}
