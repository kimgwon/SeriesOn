//
//  MovieListCell.swift
//  SeriesOn
//
//  Created by keem on 2023/06/17.
//

import UIKit

class MovieListCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var vote_avg: UILabel!
    @IBOutlet weak var vote_cnt: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        rank.layer.borderWidth = 1
        rank.layer.borderColor = UIColor.blue.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
