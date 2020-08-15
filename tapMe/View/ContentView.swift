//
//  ContentView.swift
//  tapMe
//
//  Created by Кирилл on 13.08.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//


//MARK: сделать чистку кода и декомпозицию всего

import SwiftUI

struct ContentView: View {
    
    @State var progress:CGFloat = 100
    @State var speed:TimeInterval = 0.5
    @State var changeProgress:CGFloat = 10
    @State var pointCount: Int = 0
    @State var chooseText:String = ""
    @State var firstImage = ""
    @State var secondImage = ""
    @State var timer:Timer?
    @State var looseGame = false
    @State var opacityLooseView:Bool = false
    
    let imageArray:[String] = ["арбуз","яблоко","киви","банан","авокадо","баклажан","груша","капуста","кукуруза","малина","помидор","редис","салат"]
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [.white,.gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.top)
            VStack{
                GameNameView()
                Spacer(minLength: 0)
                VStack(spacing: 70) {
                    Text(chooseText)
                        .font(.title)
                        .fontWeight(.medium)
                    HStack(spacing:50){
                        Image(firstImage)
                            .onTapGesture {
                                self.equelText(label: self.firstImage)
                            }
                            .frame(width: 100, height: 100)
                        Image(secondImage)
                            .onTapGesture {
                                self.equelText(label: self.secondImage)
                            }
                            .frame(width: 100, height: 100)
                    }
                }
                Spacer(minLength: 0)
                ProgressView(progress: $progress)
                    .padding()
                    .animation(.linear(duration:speed))
                    .frame(height: 20)
                    .padding(.bottom,35)
            }
            if looseGame{
                LooseView(count: $pointCount)
                    .frame(width: 300, height: 200)
                    .background(Color.gray)
                    .cornerRadius(15)
                    .opacity(opacityLooseView ? 1 : 0)
                    .shadow(radius: 5)
            }
        }
        .onAppear{
            self.updateData()
            (Bool.random()) ? (self.chooseText = self.firstImage.capitalized) : (self.chooseText = self.secondImage.capitalized)
            self.timer = self.createTimer()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("UserLoggedIn"))) { _ in
            withAnimation(.easeInOut(duration: 1.0)) {
                self.opacityLooseView.toggle()
            }
            self.newGame()
        }
    }
    
    private func equelText(label:String){
        if label.lowercased() == self.chooseText.lowercased(){
            pointCount += 1
            updateData()
        }else{
            self.looseBlock()
        }
    }
    
    private func updateData(){
        self.timer?.invalidate()
        self.timer = self.createTimer()
        self.firstImage = self.imageArray.randomElement()!
        self.secondImage = self.imageArray.randomElement()!
        (Bool.random()) ? (self.chooseText = self.firstImage.capitalized) : (self.chooseText = self.secondImage.capitalized)
    }
    
    private func createTimer() -> Timer{
        self.progress = 100
        return Timer.scheduledTimer(withTimeInterval: TimeInterval(self.speed), repeats: true) { (timer) in
            if self.progress > 0 {
                self.progress -= self.changeProgress
            }else{
                self.looseBlock()
            }
        }
    }
    
    private func newGame(){
        self.pointCount = 0
        self.speed = 0.5
        self.changeProgress = 10
        self.looseGame.toggle()
        self.updateData()
        (Bool.random()) ? (self.chooseText = self.firstImage.capitalized) : (self.chooseText = self.secondImage.capitalized)
        self.timer?.invalidate()
        self.timer = nil
        self.timer = self.createTimer()
    }
    
    private func looseBlock(){
        self.timer?.invalidate()
        self.looseGame.toggle()
        self.speed = 0
        self.changeProgress = 0
        self.chooseText = ""
        self.firstImage = ""
        self.secondImage = ""
        withAnimation(.easeInOut(duration: 1.0)) {
            self.opacityLooseView.toggle()
            self.progress = 100
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
