//
//  ViewModel.swift
//  FLO
//
//  Created by yun on 2022/03/16.
//

import Foundation

protocol ViewModel {
    func requestMusic(url: URL, completion: @escaping (Observable<Music>) -> ())
    func setMusic(music: Observable<Music>)
    
    var getMusic: Observable<Music> { get }
}

class FLOViewModel: ViewModel {
    private var service: Service!
    private var music = Observable<Music>(Music(singer: "", album: "", title: "", duration: 0, image: "", file: "", lyrics: ""))
    
    var getMusic: Observable<Music> {
        return music
    }

    
                
    func requestMusic(url: URL, completion: @escaping (Observable<Music>) -> ()) {
        Router.shared.request(url: url) { data in
            do {
                let music = try JSONDecoder().decode(Music.self, from: data)
                completion(Observable<Music>(music))
            } catch {
                print("decodingError")
            }
        }
    }
    
    func setMusic(music: Observable<Music>) {
        self.music = music
    }
    
    init(service: Service) {
        self.service = service
    }
}
