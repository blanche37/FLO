//
//  FLOService.swift
//  FLO
//
//  Created by yun on 2022/03/12.
//

import Foundation

protocol Service { 
    func read(completion: @escaping (Music) -> ())
}

final class FLOService: Service {
    private var repository: Repository!
    
    func read(completion: @escaping (Music) -> ()) {
        repository.read(completion: completion)
    }
    
    init(repository: Repository) {
        self.repository = repository
    }
}
