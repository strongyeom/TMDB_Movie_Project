//
//  MovieCollectionViewCell.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var movieThumbnailImage: UIImageView!
    
    @IBOutlet var movieTitleLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieThumbnailImage.backgroundColor = .green
        movieThumbnailImage.contentMode = .scaleToFill
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
    }

}
