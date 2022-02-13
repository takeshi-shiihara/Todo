//
//  TodoList.swift
//  Todo
//
//  Created by 椎原健 on 2022/01/30.
//

import SwiftUI
import CoreData

struct TodoList: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntity.time, ascending: true)], animation: .default)
    
    var todoList: FetchedResults<TodoEntity>
    
    let category: TodoEntity.Category
    
    var body: some View {
        VStack {
            List {
                ForEach(todoList) { todo in
                    if todo.category == self.category.rawValue {
                        TodoDetailRow(todo: todo, hideIcon: true)
                    }
                }
            }
            QuickNewTask(category: category)
                .padding()
        }
    }
}



struct TodoList_Previews: PreviewProvider {
    
    static let container = PersistenceController.shared.container
    static let context = container.viewContext
    
    static var previews: some View {
        
        // テストデータの全削除
        let request = NSBatchDeleteRequest(
        fetchRequest: NSFetchRequest(entityName: "TodoEntity"))
        try! container.persistentStoreCoordinator.execute(request,
                                                          with: context)

        //データを追加
        TodoEntity.create(in: context,
                          category: .ImpUrg_1st, task: "炎上プロジェクション")
        
        TodoEntity.create(in: context,
                          category: .ImpNUrg_2nd, task: "２")
        
        TodoEntity.create(in: context,
                          category: .NImpUrg_3rd, task: "３")
        
        TodoEntity.create(in: context,
                          category: .NimpNUrg_4th, task: "4")
        
        return TodoList(category: .ImpUrg_1st)
            .environment(\.managedObjectContext, context)
    }
}
