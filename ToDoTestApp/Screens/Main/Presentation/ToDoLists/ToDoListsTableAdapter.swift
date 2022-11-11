//
//  ToDoListsTableAdapter.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import RealmSwift

protocol ToDoListsTableAdapterDelegate: AnyObject {
    func itemDidSelect(at id: ObjectId)
    func deleteItem(at item: ToDoListItem)
}

/// Класс адаптера для tableView экрана списков задач
class ToDoListsTableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    public weak var delegate: ToDoListsTableAdapterDelegate?
    private var tableView: UITableView?
    private var sections: [ToDoListsSections] = []
    
    /// Функция первоначальной настройки делегатов и ячеек для tableView
    /// - Parameter tableView: Подключаемая к адаптеру tableView
    func connect(tableView: UITableView) {
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(forType: ToDoListsCell.self)
        refresh()
    }

    /// Функция отключения tableView и его делегатов
    func disconnect() {
        self.tableView?.delegate = nil
        self.tableView?.dataSource = nil
        self.tableView = nil
    }

    /// Функция обновления секций в tableView
    func update(sections: [ToDoListsSections]) {
        self.sections = sections
        refresh()
    }
    
    /// Функция обновления секций в tableView
    /// - Parameter sections: Массив секций
    /// - Parameter deletions: Индексы удаленных рядов
    /// - Parameter insertions: Индексы добавленных рядов
    /// - Parameter updates: Индексы обновленных рядов
    /// - Parameter numberOfSection: Номер секции в которой обновляем ряды
    func applyState(sections: [ToDoListsSections],
                    deletions: [Int],
                    insertions: [Int],
                    updates: [Int],
                    numberOfSection: Int) {
        self.sections = sections
        tableView?.applyChanges(deletions: deletions,
                                insertions: insertions,
                                updates: updates,
                                numberOfSection: numberOfSection)
    }

    private func refresh() {
        tableView?.reloadData()
    }

// MARK: - UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = sections[indexPath.section]
        switch cellType {
        case .toDoLists(let lists):
            let list = lists[indexPath.row]
            let cell: ToDoListsCell = tableView.dequeueReusableCell(ToDoListsCell.self, for: indexPath)
            cell.update(list: list)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cellType = sections[indexPath.section]
        switch cellType {
        case .toDoLists(let lists):
            let list = lists[indexPath.row]
            delegate?.itemDidSelect(at: list._id)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rowInSection
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let cellType = sections[indexPath.section]
        switch cellType {
        case .toDoLists(let lists):
            let list = lists[indexPath.row]
            delegate?.deleteItem(at: list)
        }
    }
}
