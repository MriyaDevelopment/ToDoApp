//
//  Assembler.swift
//  ToDoTestApp
//
//  Created by Nikita Ezhov on 09.11.2022.
//
import Swinject

extension Assembler {
    
    /// Обертка в синглтон сущности Assembler
    static let sharedAssembler: Assembler = {
        
        /// DI-контейнер
        let container = Container()
        
        /// Сущность регистрирует сущности типа Assembly в DI-контейнер
        let assembler = Assembler([
            // Регистрация сущностей assembly приложения и блока Main
            AppAssembly(),
            MainAssembly()
            ], container: container)
        return assembler
    }()
}
