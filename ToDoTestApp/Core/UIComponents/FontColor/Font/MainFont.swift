//
//  BaseFont.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 11.11.2022.
//

import UIKit
/// Кастомный шрифт приложения
enum MainFont {
    static func semiBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Poppins-SemiBold", size: size) else { return UIFont() }
        return font
    }
        
    static func regular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Poppins-Regular", size: size) else { return UIFont() }
        return font
    }
}
