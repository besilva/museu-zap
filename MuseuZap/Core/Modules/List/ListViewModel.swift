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
    var array: [Audio] { get set }
    var navigationDelegate: NavigationDelegate? { get }
    var count: Int { get }
    var delegate: ListViewModelDelegate? { get set }
//    func getAllAudios()
//    func getAudio(at indexPath: IndexPath) -> (title: String, subtitle: String)
    // TODO: faz sentido ter essa tupla gigante? SwiftLint ta com disable por enquanto
    func getAudioTable(at indexPath: IndexPath) -> (name: String, path: String, isPrivate: Bool, category: String?)
    func back()
    init(audioServices: AudioServices)
}

class ListViewModel: ListViewModelProtocol {
    var audioServices: AudioServices
    var array: [Audio] = []
    var count: Int { array.count }
    internal weak var delegate: ListViewModelDelegate?
    internal weak var navigationDelegate: NavigationDelegate?
    
    required init(audioServices: AudioServices) {
        self.audioServices = audioServices
        getArray()
    }
    
    func back() {
        // Handle back from navigation
        navigationDelegate?.handleNavigation(action: .back)
    }

    // MARK: - Core Data
    func getArray() {

        audioServices.getAllAudios { (error, audioArray) in
            if let audios = audioArray {
                // Assign teste Array
                self.array = audios
            } else {
                // Display error here because it was not possible to load season list
                // TODO: Como tratar erros + enum?
                print(error ?? "Some default error value")
            }
        }
    }

    func getAudioTable(at indexPath: IndexPath) -> (name: String, path: String, isPrivate: Bool, category: String?) {
        let element = array[indexPath.row]
        return (name: element.audioName, path: element.audioPath, isPrivate: element.isPrivate, category: element.belongsTo?.categoryName)
    }
    
}
