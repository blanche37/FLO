//
//  FLOService.swift
//  FLO
//
//  Created by yun on 2022/03/12.
//

import Foundation

protocol Repository {
    func read(completion: @escaping (Music) -> ())
    // TODO: - create, update, delete
}

class NetworkRepository: Repository {
    
    private let baseURL = URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json")
    
    func read(completion: @escaping (Music) -> ()) {
        guard let url = baseURL else {
            return
        }
        
        NetworkManager.shared.request(url: url) { data in
            let music = self.convert(data)
            completion(music)
        }

    }
    
    private func convert(_ data: Data) -> Music {
        var music: Music?
        
        do {
            music = try JSONDecoder().decode(Music.self, from: data)
        } catch {
            print(error)
        }
        return music!
    }
}

