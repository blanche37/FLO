//
//  ViewModel.swift
//  FLO
//
//  Created by yun on 2022/03/16.
//

import Foundation

protocol ViewModel {
    func getMusic(url: URL)
}

class FLOViewModel: ViewModel {
    var service: Service!
    var music: Music?
    
    func getMusic(url: URL) {
        Router.shared.request(url: url) { data in
            do {
                let music = try JSONDecoder().decode(Music.self, from: data)
                self.music = music
            } catch {
                fatalError("decodingError")
            }
        }
    }
    
    init(service: Service) {
        self.service = service
    }
}
