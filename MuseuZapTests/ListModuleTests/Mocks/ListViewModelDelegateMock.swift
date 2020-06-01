//
//  ListViewModelDelegateMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

@testable import MuseuZap

class ListViewModelDelegateMock: ListViewModelDelegate {
    func startLoading() {
        
    }
    
    var refreshFlag: Bool = false

    func stopLoading() {
    }

    func reloadTableView() {
        // To test if this funtion was called, set flag
        refreshFlag = true
    }

    func endRefreshing() {
    }

    var isFiltering: Bool = false

    var isSearchBarEmpty: Bool = false
}
