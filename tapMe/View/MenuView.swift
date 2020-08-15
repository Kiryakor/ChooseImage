//
//  Menu.swift
//  tapMe
//
//  Created by Кирилл on 15.08.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
   @Binding var startGame:Bool
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [.white,.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.top)
            VStack{
                GameNameView()
                Spacer(minLength: 0)
                Button(action: {
                    self.startGame.toggle()
                }, label: {
                    Text("Start game")
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                })
                Spacer(minLength: 0)
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    
    @State static var start:Bool = true
    
    static var previews: some View {
        MenuView(startGame: $start)
    }
}
