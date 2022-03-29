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
    private var timeObserverToken: Any?
    
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
    
    func rewind() {
        player.seek(to: CMTime(value: 0, timescale: 1))
    }
    
    func fastForward(duration: Int) {
        player.seek(to: CMTime(value: Int64(duration), timescale: 1))
    }
    
    func addTimeObserver(slider: UISlider) {
        let interval = CMTime(seconds: 0.5,
                              preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) {time in
            slider.value = Float(CMTimeGetSeconds(time))
        }
    }
}

