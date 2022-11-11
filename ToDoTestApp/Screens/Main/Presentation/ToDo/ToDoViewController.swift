//
//  ToDoViewController.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import RealmSwift

protocol ToDoDisplayLogic: AnyObject {
    func display(newState: ToDoDataFlow.ViewControllerState)
}

protocol ToDoViewControllerDelegate: AnyObject {
    func showEditToDo(id: ObjectId)
}

/// VC для экрана списка задач
final class ToDoViewController: UIViewController {
    
    weak var delegate: ToDoViewControllerDelegate?
    
    private let interactor: ToDoBusinessLogic
    
    private let listId: ObjectId
    
    private var customView: ToDoView
    
    private let tableAdapter = ToDoTableAdapter()
    
    init(interactor: ToDoBusinessLogic, listId: ObjectId) {
        self.listId = listId
        self.interactor = interactor
        self.customView = ToDoView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
        title = AppStrings.detailScreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableAdapter.connect(tableView: customView.tableView)
        tableAdapter.delegate = self
        interactor.initial()
    }
    
    @objc private func addTapped() {
        delegate?.showEditToDo(id: listId)
    }
}

extension ToDoViewController: ToDoTableAdapterDelegate {
    func deleteItem(at index: Int) {
        interactor.deleteObject(index)
    }
    
    func itemDidSelect(at item: ToDoItem) {
        interactor.toggleObject(item)
    }
}

extension ToDoViewController: ToDoDisplayLogic {
    /// Функция состояний VC
    /// - Parameter newState: Состояние VC
    func display(newState: ToDoDataFlow.ViewControllerState) {
        switch newState {
        case .setToDoList(let sections):
            tableAdapter.update(sections: sections)
        case .showEmptyState(let isEmpty):
            customView.showEmptyState(isEmpty: isEmpty)
        case .updateList(let sections,
                         let deletions,
                         let insertions,
                         let updates,
                         let numberOfSection):
            tableAdapter.applyState(sections: sections,
                                    deletions: deletions,
                                    insertions: insertions,
                                    updates: updates,
                                    numberOfSection: numberOfSection)
        case .updateTitle(let allCount,
                          let completedCount):
            customView.update(allCount: allCount,
                              completedCount: completedCount)
        }
    }
}
