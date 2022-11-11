//
//  ToDoView.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit

private extension ToDoView {
    struct Appearance {
        let topOffset: CGFloat = 5
    }
}

/// View экрана списка задач
class ToDoView: UIView {
        
    private let appearance = Appearance()
    /// Тайтл, показывающий общее и выполненное количество задач
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 14)
        label.textColor = Colors.baseGray
        label.textAlignment = .center
        return label
    }()
    
    /// TableView для секций экрана списка задач
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
        label.text = AppStrings.emptyTasksTitle
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
        title.isHidden = isEmpty
        emptyTitle.isHidden = !isEmpty
    }
    /// Обновление тайтла
    /// - Parameter allCount: Общее число задач
    /// - Parameter completedCount: Выполненные задачи
    public func update(allCount: Int, completedCount: Int) {
        title.text = "Complete \(completedCount) of \(allCount) tasks"
    }

    private func prepareView() {
        backgroundColor = Colors.baseBackground
        addSubview(title)
        addSubview(tableView)
        addSubview(emptyTitle)
    }

    private func makeConstraints() {
        title.snp.makeConstraints { make in
            make.left.right.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(appearance.topOffset)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(appearance.topOffset)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        emptyTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
