//
//  AlbumModel.swift
//  Albums
//
//  Created by Nivedita Angadi on 03/02/22.
//

import Foundation

struct AlbumModel {
    let userId: Int
    let id: Int
    let title: String

    init(album: AlbumNetworkModel) {
        userId = album.userId
        id = album.id
        title = album.title.capitalized
    }

    init(album: AlbumRealmModel) {
        userId = album.userId
        id = album.id
        title = album.title.capitalized
    }
}
