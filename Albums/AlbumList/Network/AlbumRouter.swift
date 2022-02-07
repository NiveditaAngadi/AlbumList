//
//  AlbumListRouter.swift
//  Albums
//
//  Created by Nivedita Angadi on 02/02/22.
//

import Foundation

enum AlbumRouter: Router {
    case getAlbumList

    var httpMethod: HttpMethod {
        return .get
    }

    var path: String {
        switch self {
        case .getAlbumList: return "https://jsonplaceholder.typicode.com/albums"
        }
    }
}
