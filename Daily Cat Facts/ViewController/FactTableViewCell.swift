//
//  FactTableViewCell.swift
//  Daily Cat Facts
//
//  Created by Adriaan van Schalkwyk on 2021/03/30.
//  Copyright © 2021 Adriaan. All rights reserved.
//

import UIKit

class FactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var factLabelTitle: UILabel!
    @IBOutlet weak var factLabelBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
