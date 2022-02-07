//
//  URLSessionNetworkRequestService.swift
//  Albums
//
//  Created by Nivedita Angadi on 02/02/22.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol NetworkRequestServiceContract {
    static func request<T: Codable> (_ request: Router, completionHandler: @escaping (Result<T>) -> Void)
}

class URLSessionNetworkRequestService: NetworkRequestServiceContract {
    static func request<T: Codable> (_ request: Router, completionHandler: @escaping (Result<T>) -> Void) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.timeoutIntervalForRequest = 120
        urlSessionConfiguration.timeoutIntervalForResource = 120
        urlSessionConfiguration.waitsForConnectivity = true
        let session = URLSession(configuration: urlSessionConfiguration)

        let task = session.dataTask(with: request.urlRequest) { (responseData, response, responseError) in
            if let error = responseError {
                completionHandler(.failure(error))
            } else if let jsonData = responseData {
                let decoder = JSONDecoder()
                do {
                    let responseObjects = try decoder.decode(T.self, from: jsonData)
                    let result: Result<T> = Result.success(responseObjects)
                    completionHandler(result)
                } catch {
                    completionHandler(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

