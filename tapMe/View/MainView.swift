//
//  Main.swift
//  tapMe
//
//  Created by Кирилл on 15.08.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State var startGame:Bool = false
    
    var body: some View {
        ZStack{
            if startGame{
                GameView()
            }else{
                MenuView(startGame: $startGame)
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
