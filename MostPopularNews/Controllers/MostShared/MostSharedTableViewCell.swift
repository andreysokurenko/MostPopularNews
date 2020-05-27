//
//  MostSharedTableViewCell.swift
//  MostPopularNews
//
//  Created by Andrey on 26.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class MostSharedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mostSharedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
