//
//  ToDoDataFflow.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import RealmSwift

enum ToDoDataFlow {
    /// Стейты контроллера
    enum ViewControllerState {
        case showEmptyState(Bool)
        case setToDoList([ToDoSections])
        case updateList([ToDoSections], [Int], [Int], [Int], Int)
        case updateTitle(Int, Int)
    }
}
