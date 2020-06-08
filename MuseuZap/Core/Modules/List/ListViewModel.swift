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
    var audioCategories: [AudioCategory] { get set }
    var audioCategoryServices: AudioCategoryServicesProtocol { get set }
    var searchResultsArray: [Audio] { get set }
    var searchManager: SearchResultsViewController { get set }
    var count: Int { get }
    var navigationDelegate: NavigationDelegate? { get }
    var delegate: ListViewModelDelegate? { get set }
    func handleRefresh()
    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties
    func getAudioItemProperties(at indexPath: IndexPath, withCategory category: AudioCategory) -> AudioProperties
    func performSearch(with text: String)
    func back()
    init(audioServices: AudioServicesProtocol, audioCategoryServices: AudioCategoryServicesProtocol, delegate: ListViewModelDelegate)
}

extension ListViewModelProtocol {
    func getAudioItemProperties(at indexPath: IndexPath) -> AudioProperties {
        let element = audios[indexPath.row]
        return AudioProperties(from: element)
    }

    func getAudioItemProperties(at indexPath: IndexPath, withCategory category: AudioCategory) -> AudioProperties {
        let arrayFiltered = audios.filter { (audio) -> Bool in
            return audio.category == category
        }

        let element = arrayFiltered[indexPath.row]
        return AudioProperties(from: element)
    }
}

class ListViewModel: ListViewModelProtocol {
    var audios: [Audio] = [] {
        didSet {
            self.delegate?.reloadTableView()
        }
    }
    var audioServices: AudioServicesProtocol
    var audioCategories: [AudioCategory] = []
    var audioCategoryServices: AudioCategoryServicesProtocol
    // Search
    var searchResultsArray: [Audio] = []
    var searchManager = SearchResultsViewController()
    // Count will be updated if a search starts
    var count: Int {
        if delegate?.isFiltering ?? false {
            return searchResultsArray.count
        }
        return audios.count
    }
    internal weak var delegate: ListViewModelDelegate?
    internal weak var navigationDelegate: NavigationDelegate?

    required init(audioServices: AudioServicesProtocol, audioCategoryServices: AudioCategoryServicesProtocol, delegate: ListViewModelDelegate) {
        self.audioServices = audioServices
        self.audioCategoryServices = audioCategoryServices
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
        var element = audios[indexPath.row]

        if delegate?.isFiltering ?? false {
            element = searchResultsArray[indexPath.row]
        }

        return AudioProperties(from: element)
    }
        
    // MARK: - Categories
    func retrieveAllCategories() {
        audioCategoryServices.getAllCategories { (error, audioCategories) in
            if let categories = audioCategories {
                // Assign
                self.audioCategories = categories
            } else {
                // Display here some frendiler message based on Error Type (database error or not)
                print(error ?? "Some default error value")
            }
        }
    }
    
    func retrieveAllCategoriesWith(isPrivate: Bool) {
        audioCategoryServices.getAllCategoriesWith(isPrivate: isPrivate) { (error, audioCategories) in
            if let categories = audioCategories {
                // Assign
                self.audioCategories = categories.filter({ $0.categoryName != "Sem Categoria"})
            } else {
                // Display here some frendiler message based on Error Type (database error or not)
                print(error ?? "Some default error value")
            }
        }
    }
    
    // MARK: - Search

    func performSearch(with text: String) {
//        guard text != "" else { return }
//        TODO: search should be performed using a service
        searchResultsArray = audios.filter { (audio) -> Bool in
            return audio.audioName.lowercased().contains(text.lowercased())
        }

        searchManager.model?.searchResultArray = searchResultsArray
        searchManager.viewDelegate?.reloadTableView()
    }

    // MARK: - Refresh

    func handleRefresh() {
        retrieveAllAudios()
        delegate?.reloadTableView()
    }
}
