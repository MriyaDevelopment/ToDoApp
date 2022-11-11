//
//  NSObject+Ext.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 10.11.2022.
//

import Foundation

/// Расширение NSObject необходимое для работы с tableView
public extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
    
}
