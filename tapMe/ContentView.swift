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
    @State var chooseText:String = ""
    @State var tapIsActive = false
    @State var firstImage = ""
    @State var secondImage = ""
    let imageArray:[String] = ["арбуз","яблоко"]
    @State var timer:Timer?
    
    var body: some View {
        NavigationView{
            VStack(spacing:100){
                Spacer(minLength: 0)
                Text(chooseText)
                    .font(.title)
                    .fontWeight(.medium)
                HStack(spacing:50){
                    Image(imageArray.randomElement()!).onTapGesture {
                        self.firstImage = self.imageArray.randomElement()!
                        self.secondImage = self.imageArray.randomElement()!
                        self.timer?.invalidate()
                    }
                    Image(imageArray.randomElement()!).onTapGesture {
                        self.firstImage = self.imageArray.randomElement()!
                        self.secondImage = self.imageArray.randomElement()!
                        self.timer?.invalidate()
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
                self.firstImage = self.imageArray.randomElement()!
                self.secondImage = self.imageArray.randomElement()!
                self.chooseText = self.imageArray.randomElement()?.capitalized ?? ""
                self.timer = self.createTimer()
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
    
    private func createTimer() -> Timer{
        return Timer.scheduledTimer(withTimeInterval: TimeInterval(self.speed), repeats: true) { (timer) in
            guard self.isActive else { return }
            if self.progress > 0 {
                self.progress -= 5
            }else{
                timer.invalidate()
                self.progress = 100
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
