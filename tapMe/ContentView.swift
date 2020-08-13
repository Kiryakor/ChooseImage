//
//  ContentView.swift
//  tapMe
//
//  Created by Кирилл on 13.08.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var progress:CGFloat = 100
    @State private var isActive = true
    @State var speed:TimeInterval = 1
    @State var chooseText:String = "Арбуз"
    
    var body: some View {
        NavigationView{
            VStack(spacing:100){
                Spacer(minLength: 0)
                Text(chooseText)
                    .font(.title)
                    .fontWeight(.medium)
                HStack(spacing:100){
                    Image("яблоко").onTapGesture {
                        print("tap first")
                    }
                    Image("арбуз").onTapGesture {
                        print("tap second")
                    }
                }
                Spacer(minLength: 0)
                CustomProgressView(progress: $progress)
                    .padding()
                    .animation(.linear(duration:speed))
                    .frame(height: 20)
                    .padding(.bottom,35)
            }
            .onAppear{
                self.createTimer()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.isActive = false
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.isActive = true
            }
            .navigationBarTitle("Game name")
        }
    }
    
    func createTimer(){
        Timer.scheduledTimer(withTimeInterval: TimeInterval(self.speed), repeats: true) { (timer) in
            guard self.isActive else { return }
            if self.progress > 0 {
                self.progress -= 20
            }else{
                timer.invalidate()
                self.speed -= 0.3
                self.progress = 100
                self.createTimer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
