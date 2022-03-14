//
//  Router.swift
//  FLO
//
//  Created by yun on 2022/03/14.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter {
    func request(url: URL, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router: NetworkRouter {
    
}
