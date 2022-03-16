//
//  ViewController.swift
//  FLO
//
//  Created by yun on 2022/03/12.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var musicTitleLabel: UILabel!
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
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                
                self.albumLabel.text = music.album
                self.musicTitleLabel.text = music.title
                self.singerLabel.text = music.singer
                self.durationLabel.text = self.viewModel.getTime(from: music.duration)
                MusicPlayer.shared.player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: music.file)!))
                Router.shared.request(url: URL(string: music.image)!, completion: { [weak self] data in
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


}

