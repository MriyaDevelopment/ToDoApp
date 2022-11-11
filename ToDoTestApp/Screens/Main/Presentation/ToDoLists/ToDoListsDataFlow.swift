//
//  ToDoListsDataFlow.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import RealmSwift

enum ToDoListsDataFlow {
    /// Стейты контроллера
    enum ViewControllerState {
        case showEmptyState(Bool)
        case setToDoLists([ToDoListsSections])
        case updateList([ToDoListsSections], [Int], [Int], [Int], Int)
    }
    
}
