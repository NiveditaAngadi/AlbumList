//
//  AlbumNetwork.swift
//  Albums
//
//  Created by Nivedita Angadi on 03/02/22.
//

import Foundation

protocol AlbumNetworkContract {
    func getAlbumList(completion: @escaping (_ result: Result<[AlbumNetworkModel]>) -> Void)
}

class AlbumNetwork: AlbumNetworkContract {
    func getAlbumList(completion: @escaping (Result<[AlbumNetworkModel]>) -> Void) {
        URLSessionNetworkRequestService.request(AlbumRouter.getAlbumList) { result in
            completion(result as Result<[AlbumNetworkModel]>)
        }
    }
}
