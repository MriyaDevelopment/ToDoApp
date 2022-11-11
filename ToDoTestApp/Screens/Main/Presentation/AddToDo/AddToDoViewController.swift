//
//  AddToDoViewController.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit

protocol AddToDoDisplayLogic: AnyObject {
    func display(newState: AddToDoDataFlow.ViewControllerState)
}

protocol AddToDoViewControllerDelegate: AnyObject {
    func closeScreen()
}

/// VC для экрана добавления задачи
final class AddToDoViewController: UIViewController {
    
    weak var delegate: AddToDoViewControllerDelegate?
    
    private let interactor: AddToDoBusinessLogic
    
    private var customView: AddToDoView
    
    init(interactor: AddToDoBusinessLogic) {
        self.interactor = interactor
        self.customView = AddToDoView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
        title = AppStrings.addScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.delegate = self
        customView.addTapGestureToHideKeyboard()
        interactor.initial()
    }
}

extension AddToDoViewController: AddToDoViewDelegate {
    func saveClicked(note: String) {
        let item = ToDoItem(note: note)
        interactor.addObject(item)
    }
}

extension AddToDoViewController: AddToDoDisplayLogic {
    /// Функция состояний VC
    /// - Parameter newState: Состояние VC
    func display(newState: AddToDoDataFlow.ViewControllerState) {
        switch newState {
        case .updateSuccess:
            delegate?.closeScreen()
        }
    }
}
