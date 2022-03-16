//
//  MusicPlayer.swift
//  FLO
//
//  Created by yun on 2022/03/17.
//

import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    
    var player = AVPlayer()
    var isPlaying = false
}

