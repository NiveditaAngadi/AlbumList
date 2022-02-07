//
//  AlbumDatabase.swift
//  Albums
//
//  Created by Nivedita Angadi on 04/02/22.
//

import Foundation
import RealmSwift

protocol AlbumDatabaseContract {
    func getAlbumList() -> [AlbumModel]
    func addAlbumList(_ list: [AlbumModel])
}

class AlbumDatabase: AlbumDatabaseContract {
    func getAlbumList() -> [AlbumModel] {
        let albumRealmList = DatabaseManager<AlbumRealmModel>.get(fromEntity: AlbumRealmModel.self)
        let albums: [AlbumModel] = albumRealmList.map { realmModel in
            AlbumModel(album: realmModel)
        }
        
        return albums
    }

    func addAlbumList(_ list: [AlbumModel]) {
        var albumRealmList: [AlbumRealmModel] = []
        albumRealmList = list.map({ model in
            AlbumRealmModel(model: model)
        })
        DatabaseManager<AlbumRealmModel>.add(albumRealmList)
    }
}
