//
//  DetailViewController.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet var mediaImage: UIImageView!
    
    @IBOutlet var detailTitle: UILabel!
    
    @IBOutlet var releaseDate: UILabel!
    
    @IBOutlet var starRate: UILabel!
    
    @IBOutlet var overview: UILabel!
    
    var id: Int?
    
    var media: MediaEnum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailViewController - viewDidLoad")
 
        guard let media, let id else { return }
        mediaImage.contentMode = .scaleToFill
        
        DispatchQueue.main.async {
            self.mediaImage.layer.cornerRadius = 12
            self.mediaImage.clipsToBounds = true
        }
        
//        NetworkManger.shared.detailRequest(id: id, media: media) { result in
//            guard let result else { return }
//            print("DetailVC - reuslt \(result)")
//            self.setup(result)
//        }
    }
 
    func setup(_ result: Media) {
        
        let url = URL(string: result.thumbnailTitle)
        mediaImage.kf.setImage(with: url)
        detailTitle.text = result.title
        releaseDate.text = result.releaseDate
        overview.text = result.overview
        
        navigationItem.title = result.naviTitle
        
        let star = String(format: "%.1f", result.starRate)
        starRate.text = "평점 : \(star)점"
       
    }

}
