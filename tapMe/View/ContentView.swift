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
    @State private var isActive = true
    @State var speed:TimeInterval = 0.5
    @State var chooseText:String = ""
    @State var tapIsActive = false
    @State var firstImage = ""
    @State var secondImage = ""
    @State var timer:Timer?
    @State var looseGame = false
    @State var changeProgress:CGFloat = 5
    
    let imageArray:[String] = ["арбуз","яблоко","киви","банан","авокадо","баклажан","груша","капуста","кукуруза","малина","помидор","редис","салат"]
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing:100){
                    Spacer(minLength: 0)
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
                    Spacer(minLength: 0)
                    CustomProgressView(progress: $progress)
                        .padding()
                        .animation(.linear(duration:speed))
                        .frame(height: 20)
                        .padding(.bottom,35)
                }
                if looseGame{
                    //Красивый Алерт сделать, когда ты проиграл
                }
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
//        .alert(isPresented: $looseGame) {
//             Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
//        }
    }
    
    private func equelText(label:String){
        if label.lowercased() == self.chooseText.lowercased(){
            updateData()
        }else{
            self.timer?.invalidate()
            self.isActive = true
            self.looseGame.toggle()
            self.speed = 0
            self.changeProgress = 0
            updateData()
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
            guard self.isActive else { return }
            if self.progress > 0 {
                self.progress -= self.changeProgress
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
