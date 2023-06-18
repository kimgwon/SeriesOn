//
//  SearchListCell.swift
//  SeriesOn
//
//  Created by keem on 2023/06/18.
//

import UIKit

class SearchListCell: UITableViewCell {

    @IBOutlet weak var movie_name: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var movie_id: UILabel!
    @IBOutlet weak var poster_image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
