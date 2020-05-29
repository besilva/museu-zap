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
    func stopLoading()
    func reloadTableView()
    func endRefreshing()
    var isFiltering: Bool { get }
    var isSearchBarEmpty: Bool { get }
}

protocol ListViewModelProtocol {
    var audioServices: AudioServicesProtocol { get set }
    var array: [Audio] { get set }
    var searchResultsArray: [Audio] { get set }
    var searchManager: SearchResultsViewController { get set }
    var navigationDelegate: NavigationDelegate? { get }
    var count: Int { get }
    var delegate: ListViewModelDelegate? { get set }
    func handleRefresh()
    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties
    func performSearch(with text: String)
    func back()
    init(audioServices: AudioServicesProtocol, delegate: ListViewModelDelegate)
}

class ListViewModel: ListViewModelProtocol {
    var audioServices: AudioServicesProtocol
    var array: [Audio] = []
    // Count will be updated if a search starts
    var count: Int {
        if delegate?.isFiltering ?? false {
            return searchResultsArray.count
        }
        return array.count
    }
    internal weak var delegate: ListViewModelDelegate?
    internal weak var navigationDelegate: NavigationDelegate?
    // Search
    var searchResultsArray = [Audio]()
    var searchManager = SearchResultsViewController()

    required init(audioServices: AudioServicesProtocol, delegate: ListViewModelDelegate) {
        self.audioServices = audioServices
        self.delegate = delegate
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
                // Get array is only called in Init and when refresh, so no problem to leave these delegate calls here
                self.delegate?.stopLoading()
                self.delegate?.endRefreshing()
            } else {
                // GetAll audios
                // Display here some frendiler message based on Error Type (database error or not)
                print(error ?? "Some default error value")
            }
        }
    }

    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties {
        // Initialize element with normal array and change it case isFiltering
        var element = array[indexPath.row]

        if delegate?.isFiltering ?? false {
            element = searchResultsArray[indexPath.row]
        }

        return AudioProperties(from: element)
    }

    // MARK: - Search

    // Ideia é fazer que a view faça a lógiuca da busca e CUSPA o array filtrado para a searchresults controller
    func performSearch(with text: String) {
        searchResultsArray = array.filter { (audio) -> Bool in
            return audio.audioName.lowercased().contains(text.lowercased())
        }

        searchManager.model?.searchResultArray = searchResultsArray
        searchManager.viewDelegate?.reloadTableView()
    }

    // MARK: - Refresh

    func handleRefresh() {
        getArray()
        delegate?.reloadTableView()
    }
}
