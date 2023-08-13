//
//  DetailViewController.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var mediaImage: UIImageView!
    
    @IBOutlet var detailTitle: UILabel!
    
    @IBOutlet var releaseDate: UILabel!
    
    @IBOutlet var starRate: UILabel!
    
    @IBOutlet var overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailViewController - viewDidLoad")
        NetworkManger.shared.detailRequest()
    }

}
