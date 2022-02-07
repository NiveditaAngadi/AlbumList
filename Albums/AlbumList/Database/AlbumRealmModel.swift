//
//  AlbumRealmModel.swift
//  Albums
//
//  Created by Nivedita Angadi on 04/02/22.
//

import Foundation
import RealmSwift

final class AlbumRealmModel: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
}

extension AlbumRealmModel {
    var albumModel: AlbumModel {
        return AlbumModel(album: self)
    }

    convenience init(model: AlbumModel) {
        self.init()

        self.id = model.id
        self.userId = model.userId
        self.title = model.title
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
