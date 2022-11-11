//
//  ToDoListsCell.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import SnapKit

private extension ToDoListsCell {
    struct Appearance {
        let cornerRadius: CGFloat = 15
        let hStackSpacing: CGFloat = 12
        let vStackSpacing: CGFloat = 16

        let containerEdges: CGFloat = 8
        let stackViewEdges: CGFloat = 12
    }
}
/// Ячейка tableView экрана списков задач
final class ToDoListsCell: UITableViewCell {
    
    private let appearance = Appearance()
    /// Контейнер view
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = appearance.cornerRadius
        view.layer.applySketchShadow(color: Colors.baseShadow, alpha: 0.08, x: 2, y: 2, blur: 5, spread: 0)
        return view
    }()
    /// Вертикальный stackView
    private lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .vertical
        view.spacing = appearance.vStackSpacing
        return view
    }()
    /// Горизонтальный stackView
    private lazy var hStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .horizontal
        view.spacing = appearance.hStackSpacing
        view.distribution = .fillProportionally
        return view
    }()
    /// Image для точки
    private lazy var pointImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "i_point")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    /// Тайтл (показывающий сколько задач выполнено)
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 12)
        label.textColor = Colors.baseGray
        return label
    }()
    /// Сабтайтл для названия спискаа
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = MainFont.semiBold(size: 16)
        label.textColor = Colors.baseBlack
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
        makeConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareView() {
        selectionStyle = .none
        backgroundColor = Colors.baseBackground
        contentView.addSubview(containerView)
        containerView.addSubview(vStackView)
        hStackView.addArrangedSubview(pointImage)
        hStackView.addArrangedSubview(title)
        vStackView.addArrangedSubview(hStackView)
        vStackView.addArrangedSubview(subtitle)
    }
    /// Обновление ячейки
    /// - Parameter list: Список задач для ячейки
    func update(list: ToDoListItem) {
        let countOfTasks = list.tasks.count
        let completedTasks = list.tasks.filter{ $0.isCompleted == true }.count
        title.text = "\(completedTasks) of \(countOfTasks) tasks complete"
        subtitle.text = list.text
        layoutIfNeeded()
    }

    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(appearance.containerEdges)
        }
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(appearance.stackViewEdges)
        }
    }
}
