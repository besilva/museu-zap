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
    var isFiltering: Bool { get }
    var isSearchBarEmpty: Bool { get }
}

protocol ListViewModelProtocol {
    var audios: [Audio] { get set }
    var audioServices: AudioServicesProtocol { get set }
    var searchResultArray: [Audio] { get set }
    var navigationDelegate: NavigationDelegate? { get }
    var count: Int { get }
    var delegate: ListViewModelDelegate? { get set }
    func handleRefresh()
    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties
    func performSearch(with text: String)
    func back()
    init(audioServices: AudioServicesProtocol, delegate: ListViewModelDelegate)
}

extension ListViewModelProtocol {
    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties {
        let element = audios[indexPath.row]
        return AudioProperties(from: element)
    }
}

class ListViewModel: ListViewModelProtocol {
    var audioServices: AudioServicesProtocol
    var audios: [Audio] = [] {
        didSet {
            self.delegate?.reloadTableView()
        }
    }
    var searchResultArray = [Audio]()
    var count: Int {
        if delegate?.isFiltering ?? false {
        }
            return searchResultArray.count
        return audios.count
    internal weak var delegate: ListViewModelDelegate?
    internal weak var navigationDelegate: NavigationDelegate?
    
    required init(audioServices: AudioServicesProtocol, delegate: ListViewModelDelegate) {
        self.audioServices = audioServices
        self.delegate = delegate
        retrieveAllAudios()
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
        // Initialize element with normal array and change it case isFiltering
        var element = array[indexPath.row]

        if delegate?.isFiltering ?? false {
            element = searchResultArray[indexPath.row]
        }

        return AudioProperties(from: element)
    }

    // MARK: - Search

    func performSearch(with text: String) {
        searchResultArray = array.filter { (audio) -> Bool in
            return audio.audioName.lowercased().contains(text.lowercased())
        }

        delegate?.reloadTableView()
    }

    // MARK: - Refresh

    func handleRefresh() {
        retrieveAllAudios()
        delegate?.reloadTableView()
    }
}
