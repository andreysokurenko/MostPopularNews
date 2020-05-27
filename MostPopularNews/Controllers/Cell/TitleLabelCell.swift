//
//  TitleLabelCell.swift
//  MostPopularNews
//
//  Created by Andrey on 27.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import UIKit

class TitleLabelCell: UITableViewCell {
    static let reuseId = "TitleCell"
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
