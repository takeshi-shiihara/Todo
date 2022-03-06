//
//  CategoryView.swift
//  Todo
//
//  Created by 椎原健 on 2022/01/28.
//

import SwiftUI

struct CategoryView: View {
    var category: TodoEntity.Category
    @State var numberOfTask = 0
    @State var showList = false
    @Environment(\.managedObjectContext) var viewContext
    @State var addNewTask = false
    
    fileprivate func update() {
        self.numberOfTask = TodoEntity.count(in: self.viewContext, category: self.category)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
                Image(systemName: category.image())
                    .font(.largeTitle)
                    .sheet(isPresented: $showList, onDismiss: update) {
                        TodoList(category: self.category)
                            .environment(\.managedObjectContext, self.viewContext)
                    }
            
            
                Text(category.toString())
                Text("・\(numberOfTask)タスク")
                Button(action: {
                    self.addNewTask = true
                }) {
                    Image(systemName: "plus")
                }.sheet(isPresented: $addNewTask, onDismiss: update) {
                    NewTask(category: self.category.rawValue)
                        .environment(\.managedObjectContext, self.viewContext)
                }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 150)
        .foregroundColor(.white)
        .background(category.color())
        .cornerRadius(20)
        .onTapGesture {
            self.showList = true
        }
        .onAppear {
            self.update()
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static let container = PersistenceController.shared.container
    static let context = container.viewContext
    
    static var previews: some View {
        VStack {
            CategoryView(category: .ImpUrg_1st, numberOfTask: 100)
            CategoryView(category: .ImpNUrg_2nd)
            CategoryView(category: .NImpUrg_3rd)
            CategoryView(category: .NimpNUrg_4th)
        }.environment(\.managedObjectContext, context)
    }
}
