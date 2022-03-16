//
//  ViewController.swift
//  FLO
//
//  Created by yun on 2022/03/12.
//

import UIKit

class ViewController: UIViewController {
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

