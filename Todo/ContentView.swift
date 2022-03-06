//
//  ContentView.swift
//  Todo
//
//  Created by 椎原健 on 2022/01/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            Color.tBackground
                .edgesIgnoringSafeArea(.top)
                .frame(height: 0)
            UserView(image: Image("profile"), username: "俺　参上")
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    CategoryView(category: .ImpUrg_1st)
                    Spacer()
                    CategoryView(category: .ImpNUrg_2nd)
                }
                Spacer()
                HStack(spacing: 0) {
                    CategoryView(category: .NImpUrg_3rd)
                    Spacer()
                    CategoryView(category: .NimpNUrg_4th)
                }
            }.padding()
            TaskToday()
        }.background(Color.tBackground)
            .edgesIgnoringSafeArea(.bottom)
    }
}


struct ContentView_Previews: PreviewProvider {
    static let container = PersistenceController.shared.container
    static let context = container.viewContext
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, context)
    }
}
