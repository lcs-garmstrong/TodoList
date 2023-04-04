//
//  TodoItem.swift
//  TodoList
//
//  Created by Graeme Armstrong on 2023-04-04.
//

import Foundation
struct TodoItem: Identifiable {
    var id:Int
    var description: String
    var completed: Bool
}

var existingTodoItems = [
    TodoItem(id: 1, description: "Do a workout", completed: false)
    
    ,
    
    TodoItem(id: 2, description: "Study for biology", completed: true)
    
    ,
    
    TodoItem(id: 3, description: "Finish Avenger book for Gilly", completed: false)
    
    ,
    
]
