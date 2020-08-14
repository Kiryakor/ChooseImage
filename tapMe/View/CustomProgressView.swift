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
                Capsule()
                    .fill(Color.black.opacity(0.08))
                    .frame(height: 20)
                Capsule()
                    .fill(Color.blue)
                    .frame(width: geo.size.width * self.progress / 100)
            }
        }
    }
}


struct CustomProgressView_Previews: PreviewProvider {
    
    @State static var progress:CGFloat = 80
    
    static var previews: some View {
        CustomProgressView(progress: $progress).previewLayout(.fixed(width: 500, height: 20))
    }
}
