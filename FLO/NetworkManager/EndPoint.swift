//
//  EndPoint.swift
//  FLO
//
//  Created by yun on 2022/03/14.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    
    // 현시점에서 불필요.
    //    var task: HTTPTask { get }
    //    var headers: HTTPHeaders? { get }
}
