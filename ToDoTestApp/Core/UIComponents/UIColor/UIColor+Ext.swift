//
//  UIColor+Ext.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import UIKit

/// Расширение для `UIColor` для получения правильного значения RGB политры.
extension UIColor {
    /// Инициализатор `UIColor` из hex строки
    /// - Parameter hex: строка представляющая цвет в hex
    /// - Parameter alpha: прозрачность
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") { cString.removeFirst() }
        
        if cString.count != 6 {
            self.init(hex: "ffffff")
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
