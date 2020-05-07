//
//  TableViewCellSnapshotContainer.swift
//  MuseuZapTests
//
//  Created by Ignácio Espinoso Ribeiro on 06/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

final class TableViewCellSnapshotContainer<Cell: UITableViewCell>: UIView, UITableViewDataSource, UITableViewDelegate {
    typealias CellConfigurator = (_ cell: Cell) -> Void
    typealias HeightResolver = ((_ width: CGFloat) -> (CGFloat))

    private let tableView = SnapshotTableView()
    private let configureCell: (Cell) -> Void
    private let heightForWidth: ((CGFloat) -> CGFloat)?
    
    /// Initializes container view for cell testing.
    ///
    /// - Parameters:
    ///   - width: Width of cell
    ///   - configureCell: closure which is passed to `tableView:cellForRowAt:` method to configure cell with content.
    ///   - cell: Instance of `Cell` dequeued in `tableView:cellForRowAt:`
    ///   - heightForWidth: closure which is passed to `tableView:heightForRowAt:` method to determine cell's height. When `nil` then `UITableView.automaticDimension` is used as cell's height. Defaults to `nil`.
    init(width: CGFloat, configureCell: @escaping CellConfigurator, heightForWidth: HeightResolver? = nil) {
        self.configureCell = configureCell
        self.heightForWidth = heightForWidth
        
        super.init(frame: .zero)
        
        // 1
        tableView.separatorStyle = .none
        tableView.contentInset = .zero
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor), // 2
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 1.0) // 3
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        configureCell(cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForWidth?(frame.width) ?? UITableView.automaticDimension // 4
    }
}

/// `UITableView` subclass for snapshot testing. Automatically resizes to its content size.
final class SnapshotTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            // 5
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        // 6
        layoutIfNeeded()
        
        // 7
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
