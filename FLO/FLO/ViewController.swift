//
//  ViewController.swift
//  FLO
//
//  Created by yun on 2022/03/12.
//

import UIKit

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
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let baseURL = URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json") else {
            return
        }
        
        viewModel.getMusic(url: baseURL) { music in
            self.viewModel.setMusic(music: music)
        }
        
        viewModel.getMusic(url: baseURL) { music in
            self.viewModel.setMusic(music: music)
            self.bind()
        }
        
    }
    
    private func bind() {
        viewModel.music1.bind { [weak self] music in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.albumLabel.text = music.album
                self.musicTitleLabel.text = music.title
                self.singerLabel.text = music.singer
                Router.shared.request(url: URL(string: music.image)!, completion: { data in
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.albumImageView.image = image
                    }
                })
            }
        }
    }


}

