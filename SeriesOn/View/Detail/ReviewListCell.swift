//
//  ReviewListCell.swift
//  SeriesOn
//
//  Created by keem on 2023/06/18.
//

import UIKit

class ReviewListCell: UITableViewCell {
    @IBOutlet weak var r_id: UILabel!
    @IBOutlet weak var r_rate: UILabel!
    @IBOutlet weak var r_title: UILabel!
    @IBOutlet weak var r_text: UILabel!
    @IBOutlet weak var r_date: UILabel!
    @IBOutlet weak var r_like: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
