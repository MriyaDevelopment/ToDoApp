//
//  ToDoListsPresenter.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

protocol ToDoListsPresentationLogic: AnyObject {
    func present(state: ToDoListsDataFlow.ViewControllerState)
    func present(items: Results<ToDoListItem>)
    func present(updatedItems: Results<ToDoListItem>, deletions: [Int], insertions: [Int], updates: [Int])
}

/// Презентер экрана списков задач
final class ToDoListsPresenter: ToDoListsPresentationLogic {
    weak var viewController: ToDoListsDisplayLogic?
    /// Функция отработки стейтов из интерактора в vc
    /// - Parameter state: Состояние VC
    func present(state: ToDoListsDataFlow.ViewControllerState) {
        viewController?.display(newState: state)
    }
    /// Initial формирование секций
    /// - Parameter items: Массив обьектов
    func present(items: Results<ToDoListItem>) {
        let content: [ToDoListsSections] = [.toDoLists(items)]
        viewController?.display(newState: .setToDoLists(content))
    }
    /// Формирование секций после обновления БД
    /// - Parameter updatedItems: Обновленный массив обьектов
    /// - Parameter deletions: Индексы удаленных рядов
    /// - Parameter insertions: Индексы добавленных рядов
    /// - Parameter updates: Индексы обновленных рядов
    func present(updatedItems: Results<ToDoListItem>, deletions: [Int], insertions: [Int], updates: [Int]) {
        let content: [ToDoListsSections] = [.toDoLists(updatedItems)]
        let toDoListSection = 0
        viewController?.display(newState: .updateList(content, deletions, insertions, updates, toDoListSection))
    }

}
