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
                    
                }
                
                
            }
            .navigationTitle("To Do")
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
