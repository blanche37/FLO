//
//  ViewModel.swift
//  FLO
//
//  Created by yun on 2022/03/16.
//

import UIKit

protocol ViewModel {
    var getMusic: Observable<Music> { get }
    
    func requestMusic(url: URL, completion: @escaping (Observable<Music>) -> ())
    func setMusic(music: Observable<Music>)
    func getMusicImage(data: Data, completion: @escaping (UIImage) -> ())
    func getTime(from duration: Int) -> String
}

class FLOViewModel: ViewModel {
    private var service: Service!
    private var music = Observable<Music>(Music(singer: "", album: "", title: "", duration: 0, image: "", file: "", lyrics: ""))
    
    var getMusic: Observable<Music> {
        return music
    }

    func getMusicImage(data: Data, completion: @escaping (UIImage) -> ()) {
        DispatchQueue.global().async {
            guard let image = UIImage(data: data) else {
                return
            }
            completion(image)
        }
    }
                
    func requestMusic(url: URL, completion: @escaping (Observable<Music>) -> ()) {
        NetworkManager.shared.request(url: url) { data in
            do {
                let music = try JSONDecoder().decode(Music.self, from: data)
                completion(Observable<Music>(music))
            } catch {
                print("decodingError")
            }
        }
    }
    
    func getTime(from duration: Int) -> String{
        let minute = duration / 60
        let second = duration % 60
        
        return "\(minute):\(second)"
    }
    
    func setMusic(music: Observable<Music>) {
        self.music = music
    }
    
    init(service: Service) {
        self.service = service
    }
}
