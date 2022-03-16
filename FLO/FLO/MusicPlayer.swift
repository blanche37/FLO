//
//  MusicPlayer.swift
//  FLO
//
//  Created by yun on 2022/03/17.
//

import UIKit
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    
    var player = AVPlayer()
    var isPlaying = false
    
    func play(button: UIButton) {
        isPlaying.toggle()
        if isPlaying {
            button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            player.play()
        } else {
            button.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
        }
    }
}

