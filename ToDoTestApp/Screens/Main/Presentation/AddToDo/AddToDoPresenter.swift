//
//  AddToDoPresenter.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation
import RealmSwift

protocol AddToDoPresentationLogic: AnyObject {
    func present(state: AddToDoDataFlow.ViewControllerState)
}

/// Презентер экрана добавления задачи
final class AddToDoPresenter: AddToDoPresentationLogic {
    weak var viewController: AddToDoDisplayLogic?
    /// Функция отработки стейтов из интерактора в vc
    /// - Parameter state: Состояние VC
    func present(state: AddToDoDataFlow.ViewControllerState) {
        viewController?.display(newState: state)
    }

}
