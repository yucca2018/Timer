//
//  ContentView.swift
//  MyTimer2
//
//  Created by user on 2021/06/16.
//

import SwiftUI

struct ContentView: View {
    
    @State var timerHandler : Timer?
    @State var count = 0
    @AppStorage("timer_value") var timerValue = 10
    @State var showAlert = false
    let soundPlayer = SoundPlayer()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image("backgroundTimer")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                
                VStack(spacing: 30.0) {
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)
                    
                    HStack(spacing: 40.0) {
                        Button(action: {
                            
                            startTimer()
                            
                        }) {
                            Text("スタート")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("startColor"))
                                .cornerRadius(50)
                        }
                        
                        Button(action: {
                            soundPlayer.stopAudio()
                            if let unrapedTimerHandler = timerHandler {
                                if unrapedTimerHandler.isValid == true {
                                    unrapedTimerHandler.invalidate()
                                    
                                }
                            }
                        }) {
                            Text("ストップ")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("stopColor"))
                                .cornerRadius(50)
                        }
                    }
                }
            }
            
            .onAppear {
                count = 0
            }
            
            .navigationBarItems(leading: NavigationLink(destination: SettingView()) {
                Text("秒数設定")
            })

            .alert(isPresented: $showAlert) {
                Alert(title: Text("終了"),
                    message: Text("タイマー終了時間です"),
                    dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func countDownTimer() {
        count += 1
        
        if timerValue - count <= 0 {
            timerHandler?.invalidate()
            showAlert = true
            soundPlayer.alertPlay()

        }
    }
    
    func startTimer() {
        
        if let unwrapedTimerHandler = timerHandler {
            if unwrapedTimerHandler.isValid == true {
                return
            }
        }
        
        if timerValue - count <= 0 {
            count = 0
        }
        
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            countDownTimer()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
