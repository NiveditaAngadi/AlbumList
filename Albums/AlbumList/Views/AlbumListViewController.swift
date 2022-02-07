//
//  AlbumListViewController.swift
//  Albums
//
//  Created by Nivedita Angadi on 02/02/22.
//

import UIKit

class AlbumListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ViewModelContract {
    @IBOutlet weak var albumListTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var viewModel: AlbumListModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album List"

        viewModel = AlbumListViewModel()
        viewModel.delegate = self
        viewModel.setup()

        albumListTableView.delegate = self
        albumListTableView.dataSource = self

        albumListTableView.estimatedRowHeight = 150
        albumListTableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - ViewModelContract
    func willLoadData() {
        activityIndicator.startAnimating()
    }

    func didLoadData() {
        albumListTableView.reloadData()
        activityIndicator.stopAnimating()
    }

    func showError(_ message: String) {
        showAlert(message)
    }

    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.albumList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)

        let album = viewModel.albumList[indexPath.row]
        albumCell.textLabel?.text = album.title

        return albumCell
    }

    // MARK: - Private Methods
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Retry", style: .cancel, handler: {_ in
            self.viewModel.setup()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
