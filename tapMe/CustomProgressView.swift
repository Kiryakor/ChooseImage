//
//  CustomProgressView.swift
//  tapMe
//
//  Created by Кирилл on 13.08.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import SwiftUI

struct CustomProgressView: View {
    
    @Binding var progress:CGFloat
    
    var body: some View{
        GeometryReader { (geo) in
            ZStack(alignment: .trailing){
                
                ZStack{
                    Capsule()
                        .fill(Color.black.opacity(0.08))
                        .frame(height: 20)
                }
                
                Capsule()
                    .fill(Color.blue)
                    .frame(width: geo.size.width * self.progress / 100)
            }
        }
    }
}

//struct CustomProgressView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        CustomProgressView().previewLayout(.fixed(width: 400, height: 40))
//    }
//}
