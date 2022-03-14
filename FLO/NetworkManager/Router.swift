//
//  Router.swift
//  FLO
//
//  Created by yun on 2022/03/14.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

struct Router: NetworkRouter {
 
}
