//
//  TableViewCell.swift
//  collectionView
//
//  Created by Zaid Mahdi on 2017-05-23.
//  Copyright © 2017 Zaid Mahdi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var AlbumCover: UIImageView!
    @IBOutlet weak var AlbumName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
