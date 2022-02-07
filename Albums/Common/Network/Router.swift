//
//  Router.swift
//  Albums
//
//  Created by Nivedita Angadi on 02/02/22.
//

import Foundation
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Router {
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var urlRequest: URLRequest { get }
}

extension Router {
    var urlRequest: URLRequest {
        var request = URLRequest(url: URL(string: self.path)!)
        request.httpMethod = self.httpMethod.rawValue
        return request
    }
}
