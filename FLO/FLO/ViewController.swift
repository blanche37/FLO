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
    }


}

