//
//  TodoListApp.swift
//  TodoList
//
//  Created by Graeme Armstrong on 2023-04-04.
//

import Blackbird
import SwiftUI

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
            // Pull info from database
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
