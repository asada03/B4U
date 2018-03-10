//
//  AssetTableViewCell.swift
//  B4U Wallet
//
//  Created by Andres Luis Sada Govela on 08/03/18.
//  Copyright © 2018 Andres Luis Sada Govela. All rights reserved.
//

import UIKit

class AssetTableViewCell: UITableViewCell {
    
    @IBOutlet var assetImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
//    var assetImage:UIImage? {
//        didSet {
//            assetImageView.image = assetImage!
//        }
//    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
