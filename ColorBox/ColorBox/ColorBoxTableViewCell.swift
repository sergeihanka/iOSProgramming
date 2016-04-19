//
//  ColorBoxTableViewCell.swift
//  ColorBox
//
//  Created by Sergei Hanka on 3/29/16.
//  Copyright © 2016 Sergei Hanka. All rights reserved.
//

import UIKit

class ColorBoxTableViewCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    
    func configure(color: ColorBox) {
        titleLabel.text = color.name
        descLabel.text = color.desc
    }
    
}