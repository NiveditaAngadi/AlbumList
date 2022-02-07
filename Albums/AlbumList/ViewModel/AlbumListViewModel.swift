//
//  AlbumListViewModel.swift
//  Albums
//
//  Created by Nivedita Angadi on 03/02/22.
//

import Foundation
import RealmSwift
import Reachability

protocol AlbumListModelType: ViewModelType {
    var albumList: [AlbumModel] { get }
}

class AlbumListViewModel: AlbumListModelType {
    weak var delegate: ViewModelContract?
    let albumNetwork: AlbumNetworkContract
    let albumDatabase: AlbumDatabaseContract
    var albumList: [AlbumModel] = []

    init(network: AlbumNetworkContract = AlbumNetwork(), database: AlbumDatabaseContract = AlbumDatabase()) {
        self.albumNetwork = network
        self.albumDatabase = database
    }

    func setup() {
        loadData()
    }

    private func loadData() {
        delegate?.willLoadData()
        var albums = albumDatabase.getAlbumList()
        if albums.count == 0 {
            if try! Reachability().connection == .unavailable {
                self.delegate?.showError("Please reverify the network connection and try again.")
            }
            albumNetwork.getAlbumList { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case let .failure(error):
                        self.delegate?.showError(error.localizedDescription)
                    case let .success(albumList):
                        let sortedAlbumList = albumList
                            .map { AlbumModel(album: $0)}
                            .sorted(by: { $0.title < $1.title })

                        albums = sortedAlbumList
                        self.albumDatabase.addAlbumList(sortedAlbumList)
                    }
                }
            }
        }
        albumList = albums
        self.delegate?.didLoadData()
    }
}
