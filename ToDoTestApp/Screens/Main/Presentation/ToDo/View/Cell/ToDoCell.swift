//
//  ToDoCell.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit
import SnapKit

private extension ToDoCell {
    struct Appearance {
        let cornerRadius: CGFloat = 15
        
        let buttonHeight: CGFloat = 32

        let containerEdges: CGFloat = 8
        let buttonLeading: CGFloat = 12
        let labelEdges: CGFloat = 16
        let labelLeading: CGFloat = 8
    }
}
/// Ячейка tableView экрана списка задач
final class ToDoCell: UITableViewCell {
    
    private let appearance = Appearance()
    /// Замыкание для считывания нажатия по кнопке
    var completion: (() -> Void)?
    /// Контейнер view
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = appearance.cornerRadius
        view.layer.applySketchShadow(color: Colors.baseShadow, alpha: 0.08, x: 2, y: 2, blur: 5, spread: 0)
        return view
    }()
    /// Кнопка изменения состояния задачи
    private lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()
    /// Лейбл названия задачи
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = Colors.baseBlack
        label.font = MainFont.regular(size: 14)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
        makeConstraints()
        addTarget()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareView() {
        selectionStyle = .none
        backgroundColor = Colors.baseBackground
        contentView.addSubview(containerView)
        containerView.addSubview(label)
        containerView.addSubview(button)
    }
    /// Обновление ячейки
    /// - Parameter list: Задача для ячейки
    func update(item: ToDoItem) {
        let attributedText = NSAttributedString(
            string: item.note,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        label.attributedText = item.isCompleted ? attributedText : NSAttributedString(string: item.note)
        button.setImage(item.isCompleted ? UIImage(named: "i_checked") : UIImage(named: "i_unchecked"), for: .normal)
        layoutIfNeeded()
    }

    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(appearance.containerEdges)
        }
        
        button.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(appearance.buttonLeading)
            make.centerY.equalToSuperview()
            make.size.equalTo(appearance.buttonHeight)
        }
        
        label.snp.makeConstraints { make in
            make.bottom.top.trailing.equalToSuperview().inset(appearance.labelEdges)
            make.leading.equalTo(button.snp.trailing).offset(appearance.labelLeading)
        }
    }
    
    private func addTarget() {
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc private func buttonClicked() {
        completion?()
    }
}
