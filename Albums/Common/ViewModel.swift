//
//  ViewModel.swift
//  Albums
//
//  Created by Nivedita Angadi on 03/02/22.
//

import Foundation

protocol ViewModelContract: AnyObject {
    func willLoadData()
    func didLoadData()
    func showError(_ message: String)
}

protocol ViewModelType {
    func setup()
    var delegate: ViewModelContract? { get set }
}
