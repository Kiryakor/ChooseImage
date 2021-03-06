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
                    .shadow(radius: 5)
                Spacer(minLength: 0)
                Button(action: {
                    self.startGame.toggle()
                }, label: {
                    Text("Start game")
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(20)
                })
                    .shadow(radius: 10)
                Spacer(minLength: 0)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Menu_Previews: PreviewProvider {
    
    @State static var start:Bool = true
    
    static var previews: some View {
        MenuView(startGame: $start)
    }
}
