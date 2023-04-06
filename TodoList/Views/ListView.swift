//
//  ListView.swift
//  TodoList
//
//  Created by Graeme Armstrong on 2023-04-04.
//

import Blackbird
import SwiftUI

struct ListView: View {
    
    // MARK: Stored properties
    @Environment(\.blackbirdDatabase) var db:
    Blackbird.Database?
    
    @BlackbirdLiveModels({ db in
        try await TodoItem.read(from: db)
    }) var todoItems
    
    @State var newItemDescription: String = ""
    
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter a to-do item", text: $newItemDescription)
                    
                    Button(action: {
                        Task {
                            // Write to the database
                            try await db!.transaction { core in
                                try core.query("INSERT INTO TodoItem (description) VALUES (?)", newItemDescription)
                            }
                            //Clear the input field
                            newItemDescription = ""
                        }
                        
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    })
                }
                .padding(20)
                
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
            .navigationTitle("To Do")
        }
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
        // pull from database
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
