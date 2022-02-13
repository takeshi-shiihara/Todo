//
//  UserView.swift
//  Todo
//
//  Created by 椎原健 on 2022/01/27.
//

import SwiftUI

struct UserView: View {
    
    let image: Image
    let username: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("こんにちは")
                    .foregroundColor(Color.tTitle)
                    .font(.footnote)
                Text("\(username)")
                    .foregroundColor(Color.tTitle)
                    .font(.title)
            }
            Spacer()
            image
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
        }
        .padding()
        .background(Color.tBackground)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(image: Image("profile"), username: "Inaba Shuzo")
    }
}
