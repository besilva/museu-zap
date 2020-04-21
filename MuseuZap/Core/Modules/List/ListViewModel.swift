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
    var array: [Teste] { get set }
    var navigationDelegate: NavigationDelegate? { get }
    var count: Int { get }
    var delegate: ListViewModelDelegate? { get set }
//    func getAllAudios()
//    func getAudio(at indexPath: IndexPath) -> (title: String, subtitle: String)
    func getTestTable(from array: [Teste], at indexPath: IndexPath) -> (title: String, subtitle: String)
    func back()
    init(testeServices: TesteServices)
}

class ListViewModel: ListViewModelProtocol {
    var testeServices: TesteServices
    var array: [Teste] = []
    var count: Int { array.count }
    internal weak var delegate: ListViewModelDelegate?
    internal weak var navigationDelegate: NavigationDelegate?
    
    required init(testeServices: TesteServices) {
        self.testeServices = testeServices
        getArray()
    }
    
//    func getAllAudios() {
//        delegate?.reloadTableView()
//        delegate?.stopLoading()
//    }
//
//    func getAudio(at indexPath: IndexPath) -> (title: String, subtitle: String) {
//        return array[indexPath.row]
//    }
    
    func back() {
        // Handle back from navigation
        navigationDelegate?.handleNavigation(action: .back)
    }

    // MARK: - Core Data
    func getArray() {

        testeServices.getAllTeste { (error, testeArray) in
            if let testes = testeArray {
                // Assign teste Array
                self.array = testes
            } else {
                // Display error here because it was not possible to load season list
                // TODO: Como tratar erros + enum?
                print(error ?? "Some default error value")
            }
        }
    }

    func getTestTable(from array: [Teste], at indexPath: IndexPath) -> (title: String, subtitle: String) {
        let element = array[indexPath.row]
        return (title: element.titulo!, subtitle: element.subtitulo!)
    }
    
}
