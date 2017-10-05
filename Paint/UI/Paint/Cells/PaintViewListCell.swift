//
//  PaintViewListCell.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/5.
//  Copyright © 2017年 YE. All rights reserved.
//

import UIKit

class PaintViewListCell: UITableViewCell {
    static let cellReuseIdentifier: String = "PaintViewListCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func update(with data: PaintListItem) {
        
    }
}
