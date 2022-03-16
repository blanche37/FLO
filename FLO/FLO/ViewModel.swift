//
//  ViewModel.swift
//  FLO
//
//  Created by yun on 2022/03/16.
//

import Foundation

protocol ViewModel {
    func getDuration(url: URL, completion: @escaping (Int) -> ())
}

class FLOViewModel: ViewModel {
    var service: Service!
    
    func getDuration(url: URL, completion: @escaping (Int) -> ()) {
        Router.shared.request(url: url) { data in
            do {
                let music = try JSONDecoder().decode(Music.self, from: data)
                completion(music.duration)
            } catch {
                fatalError("decodingError")
            }
        }
    }
    
    init(service: Service) {
        self.service = service
    }
}
