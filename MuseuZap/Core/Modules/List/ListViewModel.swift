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
//    Func getAllAudios()
    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties
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
                // GetAll audios
                // Display here some frendiler message based on Error Type (database error or not)
                print(error ?? "Some default error value")
            }
        }
    }

    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties {
        let element = array[indexPath.row]
        return AudioProperties(from: element)
    }
    
}
