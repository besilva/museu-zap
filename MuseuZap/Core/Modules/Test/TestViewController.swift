//
//  TestViewController.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 05/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class TestViewController: UITableViewController {
    var audioCells = [AudioCell]()
    let cellIdentifier = "audioCell"
    
    let viewModelArray = [PublicAudioCellViewModel(title: "Laboris cupidatat",
                                                           duration: 90,
                                                           audioURL: "sampleURL"),
    PublicAudioCellViewModel(title: "Laboris cupidatat exercitation",
                                                           duration: 90,
                                                           audioURL: "sampleURL"),
    PublicAudioCellViewModel(title: "Laboris cupidatat exercitation reprehenderit commodo qui proident",
                                                           duration: 90,
                                                           audioURL: "sampleURL"),
    PublicAudioCellViewModel(title: "Laboris cupidatat exercitation reprehenderit commodo qui proident Laboris cupidatat exercitation",
                                                           duration: 90,
                                                           audioURL: "sampleURL")]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .lightGray
        for i in 1 ... 4 {
            let customCellView = AudioCell(frame: CGRect(x: 0, y: 0, width: 374, height: 76))
            customCellView.viewModel = viewModelArray[i-1]
            audioCells += [customCellView]
        }
        
        tableView.register(AudioCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return audioCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? AudioCell {
            cell.titleLabel.text = audioCells[indexPath.row].titleLabel.text
            cell.durationLabel.text = audioCells[indexPath.row].durationLabel.text
            return cell
            
        }
        return UITableViewCell()
    }
}
