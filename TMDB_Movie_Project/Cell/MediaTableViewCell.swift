//
//  MediaTableViewCell.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import UIKit
import Kingfisher

class MediaTableViewCell: UITableViewCell {

    @IBOutlet var tvImage: UIImageView!
    
    @IBOutlet var tvTitle: UILabel!
    
    @IBOutlet var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tvImage.contentMode = .scaleToFill
        tvTitle.font = .systemFont(ofSize: 20, weight: .medium)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(row: TMDBTV) {
       
        settingImageKingfisher(url: row.thumbnailTitle)
        self.tvTitle.text = row.name
        self.releaseDateLabel.text = row.releaseDate
    }
    
    func settingImageKingfisher(url: String) {
        let url = URL(string: url)
        let processor = DownsamplingImageProcessor(size: tvImage.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 8)
        tvImage.kf.indicatorType = .activity
        tvImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
  
    
}
