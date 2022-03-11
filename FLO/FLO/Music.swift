//
//  Music.swift
//  FLO
//
//  Created by yun on 2022/03/12.
//

import Foundation

struct Music: Decodable {
    let singer: String
    let album: String
    let title: String
    let image: String
    let file: String
    let lyrics: String
}
