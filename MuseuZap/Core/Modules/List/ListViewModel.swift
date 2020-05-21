//
//  ListViewModel.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 08/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation
import DatabaseKit
import UIKit

protocol ListViewModelDelegate: class {
    func startLoading()
    func stopLoading()
    func reloadTableView()
    func endRefreshing()
}

protocol ListViewModelProtocol {
    var audios: [Audio] { get set }
    var navigationDelegate: NavigationDelegate? { get }
    var count: Int { get }
    var delegate: ListViewModelDelegate? { get set }
    func handleRefresh(_ refreshControl: UIRefreshControl)
    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties
    func back()
    init(audioServices: AudioServices, audios: [Audio], delegate: ListViewModelDelegate)
}

class ListViewModel: ListViewModelProtocol {
    var audioServices: AudioServices
    var audios: [Audio] = [] {
        didSet {
            self.delegate?.reloadTableView()
        }
    }
    var count: Int { audios.count }
    internal weak var delegate: ListViewModelDelegate?
    internal weak var navigationDelegate: NavigationDelegate?
    
    required init(audioServices: AudioServices, audios: [Audio], delegate: ListViewModelDelegate) {
        self.audioServices = audioServices
        self.delegate = delegate
        self.audios = audios
    }
    
    func back() {
        // Handle back from navigation
        navigationDelegate?.handleNavigation(action: .back)
    }

    // MARK: - Core Data
    func retrieveAllAudios() {
        self.delegate?.startLoading()
        audioServices.getAllAudios { (error, audioArray) in
            if let audios = audioArray {
                // Assign teste Array
                self.audios = audios
                // Get array is only called in Init and when refresh, so no problem to leave these delegate calls here
                self.delegate?.stopLoading()
                self.delegate?.endRefreshing()
            } else {
                // GetAll audios
                // Display here some frendiler message based on Error Type (database error or not)
                print("Error retrieving all audios")
                print(error ?? "Some default error value")
            }
        }
    }

    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties {
        let element = audios[indexPath.row]
        return AudioProperties(from: element)
    }

    // MARK: - Refresh

    func handleRefresh(_ refreshControl: UIRefreshControl) {
        retrieveAllAudios()
        delegate?.reloadTableView()
    }
}
