//
//  UITableView+Ext.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//
import UIKit

public extension UITableView {
    
    /// Регистрация ячейки по типу
    func register<T: UITableViewCell>(forType type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.className)
    }
    /// Регистрация хэдера/футера по типу
    func register<T: UITableViewHeaderFooterView>(forType type: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.className)
    }
    /// Регистрация Nib-ячейки
    func registerNib<T: UITableViewCell>(forType type: T.Type) {
        register(UINib(nibName: T.className,
                       bundle: Bundle(for: T.self)),
                 forCellReuseIdentifier: T.className)
    }
    
    /// Отдача переиспользуемой ячейки по indexPath
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
    /// Отдача переиспользуемой ячейки по тиупу и insexPath
    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
    
    /// Отдача переиспользуемой ячейки конкретного типа
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: T.className) as! T
    }
    
    /// Отдача переиспользуемого хэдера/футера конкретного типа
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.className) as! T
    }
    
    /// Скрывает заголовок секции
    func hideHeaderView() {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat.leastNormalMagnitude)
        let headerView = UIView(frame: frame)
        self.sectionHeaderHeight = CGFloat.leastNormalMagnitude
        self.tableHeaderView = headerView
        
    }
    
    /// Изменяет ряды в tableView в заависимости от изменений локальной БД
    func applyChanges(deletions: [Int], insertions: [Int], updates: [Int], numberOfSection: Int) {
        beginUpdates()
        deleteRows(at: deletions.map{IndexPath(row: $0, section: numberOfSection)}, with: .automatic)
        insertRows(at: insertions.map{IndexPath(row: $0, section: numberOfSection)}, with: .automatic)
        reloadRows(at: updates.map{IndexPath(row: $0, section: numberOfSection)}, with: .automatic)
        endUpdates()
    }
}
