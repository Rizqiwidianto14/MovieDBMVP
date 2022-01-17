//
//  CategoryCell.swift
//  MovieDB
//
//  Created by MacBook on 04/01/22.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryView.layer.cornerRadius = 20

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
