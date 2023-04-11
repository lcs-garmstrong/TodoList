//
//  ListItemsView.swift
//  TodoList
//
//  Created by Graeme Armstrong on 2023-04-11.
//

import Blackbird
import SwiftUI

struct ListItemsView: View {
    // MARK: Stored properties
    
    // need to query database
    @Environment(\.blackbirdDatabase) var db:
    Blackbird.Database?
    
    // list of to do items to be compelted
    @BlackbirdLiveModels var todoItems: Blackbird.LiveResults<TodoItem>
    
    // MARK: Computed properties
    var body: some View {
        List {
            
            ForEach(todoItems.results) { currentItem in
                Label(title: {
                    Text(currentItem.description)
                }, icon: {
                    if currentItem.completed == true {
                        Image(systemName: "checkmark.circle")
                    }
                    else {
                        Image(systemName: "circle")
                    }
                })
                .onTapGesture {
                    Task {
                        try await db!.transaction { core in
                            // change status
                            try core.query("UPDATE todoItem SET completed = (?) WHERE id = (?)",
                                           !currentItem.completed,
                                           currentItem.id)
                        }
                    }
                }
            }
            .onDelete(perform: removeRows)
        }
    }
    
    // MARK: Initializer(s)
    
    init(filteredOn searchText: String) {
        
        // initialize the last model
        _todoItems = BlackbirdLiveModels({ db in
            try await TodoItem.read(from: db,
            sqlWhere: "description LIKE ?", "%\(searchText)%")
        }) 
        
    }
    
    
    // MARK: Functions
    func removeRows(at offsets: IndexSet) {
        Task {
            
            try await db!.transaction{ core in
                
                // get the id of the item to be deleted
                var idList = ""
                for offset in offsets{
                    idList += "\(todoItems.results[offset].id),"
                }
                
                // remove final comama
                print(idList)
                idList.removeLast()
                print(idList)
                
                // deletethe rows from database
                try core.query(" DELETE FROM TodoItem WHERE id IN (?)", idList)
            }
        }
    }
}

struct ListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsView(filteredOn: "")
        // pull from database
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
