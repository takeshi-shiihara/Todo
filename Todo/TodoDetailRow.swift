//
//  TodoDetailRow.swift
//  Todo
//
//  Created by 椎原健 on 2022/02/04.
//

import SwiftUI

struct TodoDetailRow: View {
    @ObservedObject var todo: TodoEntity
    var hideIcon = false
    var body: some View {
        HStack {
            if !hideIcon {
                CategoryImage(TodoEntity.Category(rawValue: todo.category))
            }
            CheckBox(checked: Binding(get: {
                self.todo.state == TodoEntity.State.done.rawValue
            }, set: {
                self.todo.state = $0 ? TodoEntity.State.done.rawValue : TodoEntity.State.todo.rawValue
            })) {
                if self.todo.state == TodoEntity.State.done.rawValue {
                    Text(self.todo.task ?? "no title").strikethrough()
                } else {
                    Text(self.todo.task ?? "no title")
                }
            }.foregroundColor(self.todo.state == TodoEntity.State.done.rawValue ? .secondary : .primary)
        }.gesture(DragGesture().onChanged({ value in
            if value.predictedEndLocation.x > 200 {
                if self.todo.state != TodoEntity.State.done.rawValue {
                    self.todo.state = TodoEntity.State.done.rawValue
                }
            } else if value.predictedEndLocation.x < -200 {
                if self.todo.state != TodoEntity.State.todo.rawValue {
                    self.todo.state = TodoEntity.State.todo.rawValue
                }
                
            }
            
        }))
    }
}

struct TodoDetailRow_Previews: PreviewProvider {
    static var previews: some View {
        
        let container = PersistenceController.shared.container
        let context = container.viewContext
        
        let newTodo = TodoEntity(context: context)
        
        newTodo.task = "おい！ふざけ倒せよ〜"
        newTodo.state = TodoEntity.State.todo.rawValue
        newTodo.category = 0
        
        let newTodo1 = TodoEntity(context: context)
        newTodo1.task = "はい、セッツ！"
        newTodo1.state = TodoEntity.State.todo.rawValue
        newTodo1.category = 1
        
        let newTodo2 = TodoEntity(context: context)
        
        newTodo2.task = "ツッチ〜ツッチ〜..."
        newTodo2.state = TodoEntity.State.done.rawValue
        newTodo2.category = 2
        
        return VStack(alignment: .leading) {
            VStack {
                TodoDetailRow(todo: newTodo)
                TodoDetailRow(todo: newTodo1, hideIcon: true)
                TodoDetailRow(todo: newTodo2)
            }.environment(\.managedObjectContext, context)
        }
    }
}
