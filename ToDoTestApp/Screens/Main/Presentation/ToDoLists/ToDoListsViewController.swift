//
//  ToDoListsViewController.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//

import UIKit
import RealmSwift

protocol ToDoListsDisplayLogic: AnyObject {
    func display(newState: ToDoListsDataFlow.ViewControllerState)
}

protocol ToDoListsViewControllerDelegate: AnyObject {
    func showToDoList(id: ObjectId)
}

/// VC для экрана списков задач
final class ToDoListsViewController: UIViewController {
    
    weak var delegate: ToDoListsViewControllerDelegate?
    
    private let interactor: ToDoListsBusinessLogic
    
    private var customView: ToDoListsView
    
    private let tableAdapter = ToDoListsTableAdapter()
    
    init(interactor: ToDoListsBusinessLogic) {
        self.interactor = interactor
        self.customView = ToDoListsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
        title = AppStrings.mainScreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableAdapter.connect(tableView: customView.tableView)
        tableAdapter.delegate = self
        interactor.initial()
    }
    
    @objc private func addTapped() {
        userInputAlert(AppStrings.addListAlertTitle) { [weak self] text in
            let item = ToDoListItem(text: text)
            self?.interactor.addObject(item)
        }
    }
    
    /// Функция вызова алерта для добавления списка задач
    /// - Parameter title: Тайтл алерта
    /// - Parameter text: Текст (если нужен initial текст в textField)
    /// - Parameter callback: Колбек
    func userInputAlert(_ title: String, text: String? = nil, callback: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { field in
            field.text = text
        })
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                return
            }
            callback(text)
        })
        present(alert, animated: true)
    }
}

extension ToDoListsViewController: ToDoListsTableAdapterDelegate {
    
    func deleteItem(at item: ToDoListItem) {
        interactor.deleteObject(item)
    }
    
    func itemDidSelect(at id: ObjectId) {
        delegate?.showToDoList(id: id)
    }
}

extension ToDoListsViewController: ToDoListsDisplayLogic {
    
    /// Функция состояний VC
    /// - Parameter newState: Состояние VC
    func display(newState: ToDoListsDataFlow.ViewControllerState) {
        switch newState {
        case .setToDoLists(let sections):
            tableAdapter.update(sections: sections)
        case .showEmptyState(let isEmpty):
            customView.showEmptyState(isEmpty: isEmpty)
        case .updateList(let items,
                         let deletions,
                         let insertions,
                         let updates,
                         let numberOfSection):
            tableAdapter.applyState(sections: items,
                                    deletions: deletions,
                                    insertions: insertions,
                                    updates: updates,
                                    numberOfSection: numberOfSection)
        }
    }
}
