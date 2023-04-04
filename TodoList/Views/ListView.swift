//
//  ListView.swift
//  TodoList
//
//  Created by Graeme Armstrong on 2023-04-04.
//

import SwiftUI

struct ListView: View {
    // MARK: Stored properties
    @State var todoItems: [TodoItem] = existingTodoItems
    
    @State var newItemDescription: String = ""
    
    // MARK: COMPUTED PROPERTIES
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("Enter a to-do item", text: $newItemDescription)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    } )
                    
                }
                .padding(20)
                
                List(existingTodoItems) { currentItem in
                    HStack{
                        Image(systemName: "circle")
                            .foregroundColor(.blue)
                        Text("Do a workout")
                    }
                    
                    HStack{
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.blue)
                        Text("Study for biology")
                    }
                    
                    HStack{
                        Image(systemName: "circle")
                            .foregroundColor(.blue)
                        Text("Finish Avenger book for Gilly")
                    }
                }
            }
            
        }
        .navigationTitle("To do")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
        }
    }
}
