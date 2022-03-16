//
//  ViewModel.swift
//  FLO
//
//  Created by yun on 2022/03/16.
//

import Foundation

protocol ViewModel {
    func getMusic(url: URL, completion: @escaping (Music) -> ())
}

class FLOViewModel: ViewModel {
    var service: Service!
    
    func getMusic(url: URL, completion: @escaping (Music) -> ()) {
        Router.shared.request(url: url) { data in
            do {
                let music = try JSONDecoder().decode(Music.self, from: data)
                completion(music)
            } catch {
                fatalError("decodingError")
            }
        }
    }
    
    init(service: Service) {
        self.service = service
    }
}
