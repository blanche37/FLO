//
//  ViewModel.swift
//  FLO
//
//  Created by yun on 2022/03/16.
//

import Foundation

protocol ViewModel {
    func getMusic(url: URL, completion: @escaping (Observable<Music>) -> ())
    func setMusic(music: Observable<Music>)
    
    var music1: Observable<Music> { get }
//    var singer: String { get }
//    var album: String { get }
//    var title: String { get }
//    var duration: Int { get }
//    var image: String { get }
//    var file: String { get }
//    var lyrics: String { get }
}

class FLOViewModel: ViewModel {
    private var service: Service!
    var music = Observable<Music>(Music(singer: "", album: "", title: "", duration: 0, image: "", file: "", lyrics: ""))
    
    var music1: Observable<Music> {
        return music
    }
//    var singer: String {
//        return music.singer
//    }
//
//    var album: String {
//        return music.album
//    }
//
//    var title: String {
//        return music.title
//    }
//
//    var duration: Int {
//        return music.duration
//    }
//
//    var image: String {
//        return music.image
//    }
//
//    var file: String {
//        return music.file
//    }
//
//    var lyrics: String {
//        return music.lyrics
//    }
    
                
    func getMusic(url: URL, completion: @escaping (Observable<Music>) -> ()) {
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
