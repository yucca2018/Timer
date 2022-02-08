//
//  SoundPlayer.swift
//  MyTimer2
//
//  Created by user on 2021/06/19.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    
    let soundData = NSDataAsset(name: "catLife")!.data
    var alertPlayer: AVAudioPlayer!
    
    func alertPlay() {
        
        do {
            
            alertPlayer = try AVAudioPlayer(data: soundData)
            alertPlayer.play()
            
        } catch {
            print("音源データを再生できません！")
        }
    }
    
    func stopAudio() {
        alertPlayer.stop()
    }
}
