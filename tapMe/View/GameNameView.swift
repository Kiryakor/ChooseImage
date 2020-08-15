//
//  GameNameView.swift
//  tapMe
//
//  Created by Кирилл on 15.08.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import SwiftUI

struct GameNameView: View {
    var body: some View {
        HStack {
            Text("Game name")
                .font(.system(size: 35))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding([.top, .leading],50)
            Spacer()
        }
    }
}

struct GameNameView_Previews: PreviewProvider {
    static var previews: some View {
        GameNameView().previewLayout(.fixed(width: 400, height: 100))
    }
}
