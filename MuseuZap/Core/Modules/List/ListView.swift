//
//  ListView.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 16/04/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class ListView: UIView, ViewCodable {

    private var loader: UIActivityIndicatorView!
    private var tableView: UITableView = UITableView()
    private var cellIdentifier: String = "cell"

    var audioHandler: ((Action) -> ())?
    var viewModel: ListViewModelProtocol? {
        didSet {
            updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loader = UIActivityIndicatorView(style: .gray)
        loader.hidesWhenStopped = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
        tableView.separatorStyle = .none
        tableView.register(AudioCell.self, forCellReuseIdentifier: self.cellIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configure() {
        setupTableView()
    }
    
    func setupHierarchy() {
        addSubviews(tableView, loader)
    }
    
    func createLoader() {
        loader.startAnimating()
        loader.hidesWhenStopped = true
    }
    
    func setupConstraints() {
        tableView.setupConstraints { (tableView) in
            tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        }
        
        loader.setupConstraints { (loader) in
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    }
    
    func render() {
        createLoader()
        self.backgroundColor = UIColor.Default.background
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
}

extension ListView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }

        let audio = viewModel.getAudioItemProperties(at: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? AudioCell {
            
            let viewModel = AudioCellViewModel(title: audio.name, duration: audio.duration, audioPath: audio.path) { (action) in
//                Makes List View handle actions performed by the audio cell view model
                if let audioHandler = self.audioHandler {
                    audioHandler(action)
                }  
            }

            cell.viewModel = viewModel           
            return cell
            
        }
        return UITableViewCell()
    }
}

extension ListView: ListViewModelDelegate {
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }
    
}

extension ListView {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let audioCell = cell as? AudioCell else {
            return
        }
        CellIconManager.shared.updateCellStatus(visible: true, cell: audioCell)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let audioCell = cell as? AudioCell else {
            return
        }
        CellIconManager.shared.updateCellStatus(visible: false, cell: audioCell)
    }
}
