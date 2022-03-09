//
//  NewTask.swift
//  Todo
//
//  Created by 椎原健 on 2022/02/09.
//

    import SwiftUI

    struct NewTask: View {
        @State var showingAlert = false
        @State var task: String = ""
        @State var time: Date? = Date()
        @State var category: Int16 = TodoEntity.Category.ImpUrg_1st.rawValue
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
        
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("タスク").foregroundColor(.secondary)) {
                        TextField("タスクを入力", text: $task).foregroundColor(.primary)
                    }
                    Section(header: Toggle(isOn: Binding(isNotNil: $time, defaultValue: Date())){Text("時間").foregroundColor(.secondary)}) {
                        if time != nil {
                        DatePicker("日時", selection: Binding($time, Date()))
                        } else {
                            Text("時間未設定")
                                .foregroundColor(.secondary)
                        }
                    }
                    Picker(selection: $category, label: Text("種類").foregroundColor(.primary)) {
                        ForEach(categories, id: \.self) {category in
                            HStack {
                                CategoryImage(category)
                                Text(category.toString())
                                    .foregroundColor(.secondary)
                            }.tag(category.rawValue)
                            
                        }
                    }
                    
                    Section(header: Text("操作").foregroundColor(.secondary)) {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack(alignment: .center) {
                                Image(systemName: "minus.circle.fill")
                                Text("キャンセル")
                            }.foregroundColor(.red)
                        }
                    }
                }.navigationBarTitle("タスクの追加")
                    .navigationBarItems(trailing: Button(
                        action: {
                            if self.task.isEmpty {
                                self.showingAlert = true
                            } else {
                        TodoEntity.create(in: self.viewContext,
                                          category: TodoEntity.Category(rawValue: self.category) ?? .ImpUrg_1st,
                                          task: self.task,
                                          time: self.time)
                        self.save()
                        self.presentationMode.wrappedValue.dismiss()
                            }}) {
                        Text("保存")
                            .foregroundColor(.blue)
                    })
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("タスクが空です"))
                    }
            }
        }
    }

    struct NewTask_Previews: PreviewProvider {
        
        static let container = PersistenceController.shared.container
        static let context = container.viewContext
        
        static var previews: some View {
            NewTask()
                .environment(\.managedObjectContext, context)
        }
    }
