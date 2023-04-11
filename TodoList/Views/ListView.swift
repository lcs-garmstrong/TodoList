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
    
    // the item currently being added
    @State var newItemDescription: String = ""
    
    // the current search text
    @State var searchText = ""
    
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
                
                ListItemsView(filteredOn: searchText)
                .searchable(text: $searchText)
                
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
