//
//  ToDoPresenter.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

protocol ToDoPresentationLogic: AnyObject {
    func present(state: ToDoDataFlow.ViewControllerState)
    func present(items: Results<ToDoItem>)
    func present(updatedItems: Results<ToDoItem>, deletions: [Int], insertions: [Int], updates: [Int])
}

/// Презентер экрана списка задач
final class ToDoPresenter: ToDoPresentationLogic {
    weak var viewController: ToDoDisplayLogic?
    /// Функция отработки стейтов из интерактора в vc
    /// - Parameter state: Состояние VC
    func present(state: ToDoDataFlow.ViewControllerState) {
        viewController?.display(newState: state)
    }
    /// Initial формирование секций
    /// - Parameter items: Массив обьектов
    func present(items: Results<ToDoItem>) {
        let content: [ToDoSections] = [.toDoList(items)]
        viewController?.display(newState: .setToDoList(content))
    }
    
    /// Формирование секций после обновления БД
    /// - Parameter updatedItems: Обновленный массив обьектов
    /// - Parameter deletions: Индексы удаленных рядов
    /// - Parameter insertions: Индексы добавленных рядов
    /// - Parameter updates: Индексы обновленных рядов
    func present(updatedItems: Results<ToDoItem>, deletions: [Int], insertions: [Int], updates: [Int]) {
        let content: [ToDoSections] = [.toDoList(updatedItems)]
        let toDoListSection = 0
        viewController?.display(newState: .updateList(content, deletions, insertions, updates, toDoListSection))
    }

}
