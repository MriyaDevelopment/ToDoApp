//
//  ToDoSections.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

/// Секции для tableView
enum ToDoSections {
    /// Секция списков задач
    case toDoList(Results<ToDoItem>)
    
    /// Переменная для расчета числа рядов в секциях tableView
    var rowInSection: Int {
        switch self {
        case .toDoList(let models):
            return models.count
        }
    }
}
