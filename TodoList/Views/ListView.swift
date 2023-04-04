//
//  ListView.swift
//  TodoList
//
//  Created by Graeme Armstrong on 2023-04-04.
//

import SwiftUI

struct ListView: View {
    
    
    // MARK: COMPUTED PROPERTIES
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("Enter a to-do item", text: Binding.constant(""))
                    
                    Button(action: {
                        
                    }, label: {
                        Text("ADD")
                            .font(.caption)
                    } )
                    
                }
                .padding()
                
                List{
                    
                    Text("Do a workout")
                    Text("Study for biology")
                    Text("Finish Avenger book for Gilly")
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
