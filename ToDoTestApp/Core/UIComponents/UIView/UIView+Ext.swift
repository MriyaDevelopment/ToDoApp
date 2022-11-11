//
//  UIView+Ext.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit

extension UIView {
    /// Скрытие со scale анимацией
    func hideWithScale(duration: TimeInterval) {
        guard !isHidden else { return }
        UIView.animate(withDuration: duration) {
            let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.transform = scale
        } completion: { (_) in
            self.transform = .identity
            self.isHidden = true
        }
    }
    /// Показ со scale анимацией
    func showWithScale(duration: TimeInterval) {
        guard isHidden else { return }
        isHidden = false
        let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
        self.transform = scale
        UIView.animate(withDuration: duration) {
            self.transform = .identity
        }
    }
    
    /// Скрыытие клавиатуры по нажатию на вью
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        tapGesture.cancelsTouchesInView = false //эта строка нужна чтобы не блокировать didSelectItem у CollectionView и TableView
        addGestureRecognizer(tapGesture)
    }
    
}
