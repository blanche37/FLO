//
//  ViewModel.swift
//  FLO
//
//  Created by yun on 2022/03/16.
//

import Foundation

protocol ViewModel {
    func getMusic() -> Music
    func getDuration(url: URL, completion: @escaping (Int) -> ())
}
