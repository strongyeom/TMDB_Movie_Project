//
//  MovieCollectionViewCell.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var movieThumbnailImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieThumbnailImage.contentMode = .scaleToFill
    }
    
    func confiure(item: TMDBMovie) {
        let url = URL(string: item.thumbnailTtle)!
       // self.movieThumbnailImage.kf.setImage(with: url)
        
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            DispatchQueue.main.async {
                self.movieThumbnailImage.image = UIImage(data: data)
            }
        }
       
        
       
        
    }

}
