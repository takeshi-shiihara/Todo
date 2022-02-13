//
//  EditTask.swift
//  Todo
//
//  Created by 椎原健 on 2022/02/12.
//

import SwiftUI

struct EditTask: View {
    @ObservedObject var todo: TodoEntity
    @State var showingSheet = false
    var categories: [TodoEntity.Category] = [.ImpUrg_1st, .ImpNUrg_2nd, .NImpUrg_3rd, .NimpNUrg_4th]
    @Environment(\.managedObjectContext) var viewContext
    
    fileprivate func save() {
        do {
            try self.viewContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    fileprivate func delete() {
        viewContext.delete(todo)
        save()
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            Form {
                Section(header: Text("タスク")) {
                    TextField("タスクを入力", text: Binding($todo.task,"newTask"))
                }
                Section(header: Toggle(isOn: Binding(isNotNil: $todo.time, defaultValue: Date())){Text("時間")}) {
                    if todo.time != nil {
                        DatePicker("日時", selection: Binding($todo.time, Date()))
                    } else {
                        Text("時間未設定")
                            .foregroundColor(.secondary)
                    }
                }
                Picker("種類", selection: $todo.category) {
                    ForEach(categories, id: \.self) {category in
                        HStack {
                            CategoryImage(category)
                            Text(category.toString())
                        }.tag(category.rawValue)
                        
                    }
                }
                
                Section(header: Text("操作")) {
                    Button(action: {
                        self.showingSheet = true
                    }) {
                        HStack(alignment: .center) {
                            Image(systemName: "minus.circle.fill")
                            Text("Delete")
                        }.foregroundColor(.red)
                    }
                }
            }.navigationBarTitle("タスクの編集")
                .navigationBarItems(trailing: Button(action: {
                    self.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("閉じる")
                })
                .actionSheet(isPresented: $showingSheet) {
                    ActionSheet(title: Text("タスクの削除"), message: Text("このタスクを削除します。よろしいですか？"), buttons: [
                        .destructive(Text("削除")) {
                        self.delete()
                        self.presentationMode.wrappedValue.dismiss()
                    },
                        .cancel(Text("キャンセル"))
                    ])
                }
        }
}

struct EditTask_Previews: PreviewProvider {
    
    static let container = PersistenceController.shared.container
    static let context = container.viewContext
    
    static var previews: some View {
        let newTodo = TodoEntity(context: context)
        
        return NavigationView {
        EditTask(todo: newTodo)
            .environment(\.managedObjectContext, context)
        }
    }
}
