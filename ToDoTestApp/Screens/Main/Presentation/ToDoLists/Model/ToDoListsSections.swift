//
//  ToDoListsSections.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

/// Секции для tableView
enum ToDoListsSections {
    /// Секция списков задач
    case toDoLists(Results<ToDoListItem>)
    
    /// Переменная для расчета числа рядов в секциях tableView
    var rowInSection: Int {
        switch self {
        case .toDoLists(let models):
            return models.count
        }
    }
}
