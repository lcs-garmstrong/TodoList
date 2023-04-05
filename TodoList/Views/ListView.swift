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

//                        // Get last todo item id

//                        let lastId = todoItems.last!.id

//

//                        // Create new todo item

//                        let newId = lastId + 1

//

//                        //Create the new todo item

//                        let newTodoItem = TodoItem(id: newId,

//                                                   description: newItemDescription,

//                                                   completed: false)

                        

                    }, label: {

                        Text("ADD")

                            .font(.caption)

                    })

                }

                .padding(20)

                

                List(todoItems.results) { currentItem in

                    HStack{

                        Image(systemName: "circle")

                        Text(currentItem.description)

                    }

                }

                                

            }

        }

        .navigationTitle("To Do")

    }

}



struct SwiftUIView_Previews: PreviewProvider {

    static var previews: some View {

        NavigationView{

        ListView()

    }

}

}
