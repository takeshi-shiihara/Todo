//
//  CategoryImage.swift
//  Todo
//
//  Created by 椎原健 on 2022/01/22.
//

import SwiftUI

struct CategoryImage: View {
    
    var category: TodoEntity.Category
    
    init(_ category: TodoEntity.Category?) {
        self.category = category ?? .ImpUrg_1st
    }
    
    var body: some View {
        Image(systemName: category.image())
            .resizable()
            .scaledToFit()
            .foregroundColor(.white)
            .padding(10.0)
            .frame(width: 40, height: 40)
            .background(category.color())
            .cornerRadius(10)
            
    }
}

struct CategoryImage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImage(TodoEntity.Category.ImpUrg_1st)
    }
}
