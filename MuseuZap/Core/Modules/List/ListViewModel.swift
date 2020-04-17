//
//  ListViewModel.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 08/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

protocol ListViewModelDelegate: class {
    func stopLoading()
    func reloadTableView()
}

protocol ListViewModelProtocol {
    var navigationDelegate: Delegatable? { get }
    var count: Int { get }
    var delegate: ListViewModelDelegate? { get set }
    func getAllAudios()
    func getAudio(at indexPath: IndexPath) -> (title: String, subtitle: String)
    func back()
    init(array: [(String, String)])
}

class ListViewModel: ListViewModelProtocol {
    var array = [("titulo", "subtitulo")]
    var count: Int { array.count }
    internal weak var delegate: ListViewModelDelegate?
    internal weak var navigationDelegate: Delegatable?
    
    required init(array: [(String, String)]) {
        self.array = array
    }
    
    func getAllAudios() {
        delegate?.reloadTableView()
        delegate?.stopLoading()
    }
    
    func getAudio(at indexPath: IndexPath) -> (title: String, subtitle: String) {
        return array[indexPath.row]
    }
    
    func back() {
        // Handle back from navigation
        navigationDelegate?.handleNavigation(action: .back)
    }
    
}
