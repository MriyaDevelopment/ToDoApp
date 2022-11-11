//
//  ToDoListTableAdapter.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import RealmSwift

protocol ToDoTableAdapterDelegate: AnyObject {
    func itemDidSelect(at item: ToDoItem)
    func deleteItem(at index: Int)
}

/// Класс адаптера для tableView экрана списка задач
class ToDoTableAdapter: NSObject, UITableViewDelegate, UITableViewDataSource {

    public weak var delegate: ToDoTableAdapterDelegate?
    private var tableView: UITableView?
    private var sections: [ToDoSections] = []

    /// Функция первоначальной настройки делегатов и ячеек для tableView
    /// - Parameter tableView: Подключаемая к адаптеру tableView
    func connect(tableView: UITableView) {
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(forType: ToDoCell.self)
        refresh()
    }

    /// Функция отключения tableView и его делегатов
    func disconnect() {
        self.tableView?.delegate = nil
        self.tableView?.dataSource = nil
        self.tableView = nil
    }

    /// Функция обновления секций в tableView
    /// - Parameter sections: Массив секций
    func update(sections: [ToDoSections]) {
        self.sections = sections
        refresh()
    }
    
    /// Функция обновления секций в tableView
    /// - Parameter sections: Массив секций
    /// - Parameter deletions: Индексы удаленных рядов
    /// - Parameter insertions: Индексы добавленных рядов
    /// - Parameter updates: Индексы обновленных рядов
    /// - Parameter numberOfSection: Номер секции в которой обновляем ряды
    func applyState(sections: [ToDoSections],
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
        case .toDoList(let items):
            let item = items[indexPath.row]
            let cell: ToDoCell = tableView.dequeueReusableCell(ToDoCell.self, for: indexPath)
            cell.update(item: item)
            cell.completion = { [weak self] in
                self?.delegate?.itemDidSelect(at: item)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cellType = sections[indexPath.section]
        switch cellType {
        case .toDoList(let items):
            let item = items[indexPath.row]
            delegate?.itemDidSelect(at: item)
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
        case .toDoList:
            delegate?.deleteItem(at: indexPath.row)
        }
    }
}
