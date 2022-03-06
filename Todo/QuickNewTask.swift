//
//  QuickNewTask.swift
//  Todo
//
//  Created by 椎原健 on 2022/01/29.
//

import SwiftUI

struct QuickNewTask: View {
    let category: TodoEntity.Category
    @State var newTask: String = ""
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func addNewTask() {
        TodoEntity.create(in: self.viewContext,
                          category: self.category,
                          task: self.newTask)
        self.newTask = ""
    }
    
    fileprivate func cancelTask() {
        self.newTask = ""
    }
    
    var body: some View {
        HStack {
            TextField("新しいタスク", text: $newTask) {
                self.addNewTask()
            }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {addNewTask()}) {
                Text("追加")
                    .foregroundColor(.blue)
            }
            Button(action: {cancelTask()}) {
                Text("Cancel")
                    .foregroundColor(.red)
            }
        }
    }
}

struct QuickNewTask_Previews: PreviewProvider {
    
    static let container = PersistenceController.shared.container
    static let context = container.viewContext
    
    static var previews: some View {
        QuickNewTask(category: .ImpUrg_1st)
            .environment(\.managedObjectContext, context)
    }
}
