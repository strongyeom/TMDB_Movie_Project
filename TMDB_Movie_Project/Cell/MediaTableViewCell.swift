//
//  MediaTableViewCell.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    @IBOutlet var tvImage: UIImageView!
    
    @IBOutlet var tvTitle: UILabel!
    
    @IBOutlet var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tvImage.backgroundColor = .red
        
        tvTitle.font = .systemFont(ofSize: 20, weight: .medium)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
