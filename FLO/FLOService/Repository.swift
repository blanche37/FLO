//
//  FLOService.swift
//  FLO
//
//  Created by yun on 2022/03/12.
//

import Foundation

protocol Repository {
    func read(completion: @escaping (Music) -> ())
}

struct NetworkRepository: Repository {
    
    private let baseURL = "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json"
    
    func read(completion: @escaping (Music) -> ()) {
        URLSession.shared.dataTask(with: URL(string: baseURL)!) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                      return
                  }
            completion(convert(data))
            
        }.resume()
    }
    
    private func convert(_ data: Data) -> Music {
        var music: Music!
        
        do {
            music = try JSONDecoder().decode(Music.self, from: data)
        } catch {
            print(error)
        }
        return music
    }
}

