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
    @State var speed:TimeInterval = 0.5
    @State var chooseText:String = ""
    @State var tapIsActive = false
    @State var firstImage = ""
    @State var secondImage = ""
    @State var timer:Timer?
    
    let imageArray:[String] = ["арбуз","яблоко","киви","банан","авокадо","баклажан","груша","капуста","кукуруза","малина","помидор","редис","салат"]
    
    var body: some View {
        NavigationView{
            VStack(spacing:100){
                Spacer(minLength: 0)
                Text(chooseText)
                    .font(.title)
                    .fontWeight(.medium)
                HStack(spacing:50){
                    Image(firstImage)
                        .onTapGesture {
                            self.updateData()
                        }
                    .frame(width: 100, height: 100)
                    Image(secondImage)
                        .onTapGesture {
                            self.updateData()
                        }
                    .frame(width: 100, height: 100)
                }
                Spacer(minLength: 0)
                CustomProgressView(progress: $progress)
                    .padding()
                    .animation(.linear(duration:speed))
                    .frame(height: 20)
                    .padding(.bottom,35)
            }
            .onAppear{
                self.updateData()
                (Bool.random()) ? (self.chooseText = self.firstImage.capitalized) : (self.chooseText = self.secondImage.capitalized)
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
    
    private func updateData(){
        self.timer?.invalidate()
        self.timer = self.createTimer()
        self.firstImage = self.imageArray.randomElement()!
        self.secondImage = self.imageArray.randomElement()!
        (Bool.random()) ? (self.chooseText = self.firstImage.capitalized) : (self.chooseText = self.secondImage.capitalized)
        
        //запилить проверку
    }
    
    private func createTimer() -> Timer{
        self.progress = 100
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
