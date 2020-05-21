//
//  ListViewModelDelegateMock.swift
//  MuseuZapTests
//
//  Created by Ivo Dutra on 21/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

@testable import MuseuZap

class ListViewModelDelegateMock: ListViewModelDelegate {
    func stopLoading() {
    }

    func reloadTableView() {
    }

    func endRefreshing() {
    }

    var isFiltering: Bool = false

    var isSearchBarEmpty: Bool = false
}
