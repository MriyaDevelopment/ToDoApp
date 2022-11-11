//
//  AddToDoView.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit

private extension AddToDoView {
    struct Appearance {
        let textViewCornerRadius: CGFloat = 12
        let textViewBorderWidth: CGFloat = 1
        let buttonCornerRadius: CGFloat = 7
        
        let textViewHeight: CGFloat = 150
        let buttonHeight: CGFloat = 50
        
        let baseHInset: CGFloat = 16
        let buttonTopOffset: CGFloat = 24
    }
}

protocol AddToDoViewDelegate: AnyObject {
    func saveClicked(note: String)
}

/// View экрана добавления задачи
class AddToDoView: UIView {
    
    weak var delegate: AddToDoViewDelegate?
    
    private let appearance = Appearance()
    /// Плейсхолдер для текствью
    private lazy var placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = AppStrings.placeholderTitle
        placeholderLabel.font = MainFont.regular(size: 14)
        placeholderLabel.textColor = Colors.baseGray
        placeholderLabel.sizeToFit()
        return placeholderLabel
    }()
    /// Текствью для добавления названия задачи
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.layer.cornerRadius = appearance.textViewCornerRadius
        textView.layer.borderWidth = appearance.textViewBorderWidth
        textView.layer.borderColor = Colors.baseGrayAlpha.cgColor
        textView.font = MainFont.regular(size: 14)
        textView.addSubview(placeholderLabel)
        if let pointSize = textView.font?.pointSize {
            placeholderLabel.frame.origin = CGPoint(x: 5, y: pointSize / 2)
        }
        placeholderLabel.isHidden = !textView.text.isEmpty
        return textView
    }()
    /// Кнопка для добавления задачи
    private lazy var button: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = Colors.baseButtonColor.withAlphaComponent(0.5)
        button.setTitle(AppStrings.buttonTitle, for: .normal)
        button.titleLabel?.font = MainFont.semiBold(size: 16)
        button.layer.cornerRadius = appearance.buttonCornerRadius
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        prepareView()
        makeConstraints()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        backgroundColor = Colors.baseBackground
        addSubview(textView)
        addSubview(button)
    }
    
    private func makeConstraints() {
        textView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(appearance.baseHInset)
            make.height.equalTo(appearance.textViewHeight)
        }
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(appearance.baseHInset)
            make.top.equalTo(textView.snp.bottom).offset(appearance.buttonTopOffset)
            make.height.equalTo(appearance.buttonHeight)
        }
    }
    
    private func addTarget() {
        button.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
    }
    
    @objc private func saveClicked() {
        guard let text = textView.text else { return }
        delegate?.saveClicked(note: text)
    }
}

extension AddToDoView: UITextViewDelegate {
    /// Блокировкаа кнопки добавления задачи при пустом тексте
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        button.isEnabled = !textView.text.isEmpty
        if textView.text.isEmpty {
            button.backgroundColor = Colors.baseButtonColor.withAlphaComponent(0.5)
        } else {
            button.backgroundColor = Colors.baseButtonColor
        }
    }
}
