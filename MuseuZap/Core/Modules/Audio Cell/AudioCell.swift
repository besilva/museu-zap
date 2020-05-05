//
//  AudioCell.swift
//  MuseuZap
//
//  Created by Ignácio Espinoso Ribeiro on 04/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import UIKit

class AudioCell: UITableViewCell {
    let cellView: AudioCellView = {
        let view = AudioCellView(frame: CGRect(x: 0, y: 0, width: 374, height: 76))
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(cellView)
    }
}
