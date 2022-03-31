//
//  Router.swift
//  FLO
//
//  Created by yun on 2022/03/14.
//

import Foundation

protocol NetworkRouter {
    func request(url: URL, completion: @escaping (Data) -> ())
    func cancel()
}

final class NetworkManager: NetworkRouter {
    static let shared = NetworkManager()
    
    private var task: URLSessionTask?
    
    func request(url: URL, completion: @escaping (Data) -> ()) {
        let session = URLSession.shared
        
        task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  (200..<300).contains(response.statusCode) else {
                      return
                  }
            completion(data)
        })

        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
