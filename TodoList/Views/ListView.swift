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
            }
            
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}