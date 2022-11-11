//
//  ToDoListsView.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit

/// View экрана списков задач
class ToDoListsView: UIView {
            
    /// TableView для секций экрана списков задач
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    /// Тайтл для empty-state
    private lazy var emptyTitle: UILabel = {
        let label = UILabel()
        label.text = AppStrings.emptyListsTitle
        label.font = MainFont.regular(size: 14)
        label.textColor = Colors.baseGray
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        prepareView()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Show/Hide пустое состояние
    /// - Parameter isEmpty: Флаг пустого состояния
    public func showEmptyState(isEmpty: Bool) {
        if isEmpty {
            tableView.hideWithScale(duration: 0.4)
        } else {
            tableView.showWithScale(duration: 0.4)
        }
        emptyTitle.isHidden = !isEmpty
    }

    private func prepareView() {
        backgroundColor = Colors.baseBackground
        addSubview(tableView)
        addSubview(emptyTitle)
    }

    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        emptyTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
