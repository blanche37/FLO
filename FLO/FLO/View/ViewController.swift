//
//  ViewController.swift
//  FLO
//
//  Created by yun on 2022/03/12.
//

import UIKit
import AVFoundation
import MarqueeLabel
import Lottie

final class ViewController: UIViewController {
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var musicTitleLabel: MarqueeLabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var lyricsLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var forwordButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    
    var viewModel: ViewModel!
    var hapticManager = HapticManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.5
        self.progressSlider.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        MusicPlayer.shared.addTimeObserver(slider: progressSlider)
        guard let baseURL = URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json") else {
            return
        }
        
        viewModel.requestMusic(url: baseURL) { [weak self] music in
            guard let self = self else {
                return
            }
            
            self.viewModel.setMusic(music: music)
            self.bind()
        }
        
    }
    
    private func bind() {
        viewModel.getMusic.bind { [weak self] music in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                print(self.musicTitleLabel.type)
                self.albumLabel.text = music.album
                self.musicTitleLabel.text = music.title
                self.singerLabel.text = music.singer
                self.durationLabel.text = self.viewModel.getTime(from: music.duration)
                self.progressSlider.maximumValue = Float(music.duration)
                MusicPlayer.shared.player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: music.file)!))
                NetworkManager.shared.request(url: URL(string: music.image)!, completion: { [weak self] data in
                    guard let self = self else {
                        return
                    }
        
                    self.viewModel.getMusicImage(data: data) { image in
                        DispatchQueue.main.async {
                            self.albumImageView.image = image
                        }
                    }
                })
            }
        }
    }
    
    @IBAction func touchUpPlayButton(_ sender: UIButton) {
        MusicPlayer.shared.play(button: playButton)
    }
    
    @IBAction func touchUpRepeatButton(_ sender: UIButton) {
        if repeatButton.alpha == 1.0 {
            repeatButton.alpha = 0.4
        } else {
            repeatButton.alpha = 1.0
        }
    }
    
    @IBAction func touchUpRewindButton(_ sender: UIButton) {
        MusicPlayer.shared.rewind()
    }
    
    @IBAction func touchUpForwordButton(_ sender: UIButton) {
        MusicPlayer.shared.fastForward(duration: viewModel.getMusic.value.duration)
    }
    
    @IBAction func touchUpHeartButton(_ sender: UIButton) {
        if heartButton.imageView?.image == UIImage(systemName: "suit.heart") {
            hapticManager?.playSlice()
            animationView.isHidden = false
            animationView.play { [weak self] _ in
                guard let self = self else {
                    return
                }
                
                self.animationView.isHidden = true
            }
            
            heartButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
    }
    
    @objc func valueChanged() {
        let seekTime = CMTimeMakeWithSeconds(Float64(progressSlider.value), preferredTimescale: 1)
        MusicPlayer.shared.player.seek(to: seekTime)
    }
}

