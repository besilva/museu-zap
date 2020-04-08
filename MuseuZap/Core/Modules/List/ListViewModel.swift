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
    var count: Int { get }
    var delegate: ListViewModelDelegate? { get set }
    func getAllAudios()
    func getAudiot(at indexPath: IndexPath) -> (title: String, subtitle: String)
    func back()
}

class ListViewModel: ListViewModelProtocol {
    var array = [("titulo", "subtitulo")]
    var count: Int { array.count }
    internal weak var delegate: ListViewModelDelegate?
    
    func getAllAudios() {
        //get from some api
        delegate?.reloadTableView()
    }
    
    func getAudiot(at indexPath: IndexPath) -> (title: String, subtitle: String) {
        return array[indexPath.row]
    }
    
    func back() {
        //handle back from navigation
    }
    
    
}
