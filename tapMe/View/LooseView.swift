//
//  LooseView.swift
//  tapMe
//
//  Created by Кирилл on 14.08.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import SwiftUI

struct LooseView: View {
    
    @Binding var count:Int
    
    var body: some View {
        VStack(spacing:20){
            Text("Вы проиграли")
                .font(.title)
                .fontWeight(.bold)
            Text("Ваш счёт: \(count)")
                .font(.callout)
                .fontWeight(.medium)
            HStack(spacing: 10){
                Button(action: {
                    NotificationCenter.default.post(name: Notification.Name("UserLoggedIn"), object: nil)
                }, label: {
                    Text("Новая игра")
                        .frame(width: 100, height: 20)
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.blue)
                        .cornerRadius(20)
                })
                Button(action: {
                    
                }, label: {
                    Text("Магазин")
                        .frame(width: 100, height: 20)
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color.blue)
                        .cornerRadius(20)
                })
            }
        }
    }
}

struct LooseView_Previews: PreviewProvider {
    
    @State static var count:Int = 4
    
    static var previews: some View {
        LooseView(count: $count).previewLayout(.fixed(width: 300, height: 200))
    }
}
