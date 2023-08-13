//
//  ViewController.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import UIKit

class MainViewController: UIViewController {
    
    
    
    @IBOutlet var movieCollectionView: UICollectionView!
    @IBOutlet var mediaTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
        setupMedia()
    }
    
    func setupMovie() {
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        let movieNib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        movieCollectionView.register(movieNib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        settingCollectionViewLayout()
    }
    
    func settingCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width / 3, height: width / 2)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    
        movieCollectionView.collectionViewLayout = layout
    }
    
    func setupMedia() {
        mediaTableView.dataSource = self
        mediaTableView.delegate = self
        let mediaNib = UINib(nibName: MediaTableViewCell.identifier, bundle: nil)
        mediaTableView.register(mediaNib, forCellReuseIdentifier: MediaTableViewCell.identifier)
        mediaTableView.rowHeight = 120
    }

}



extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as? MediaTableViewCell else { return UITableViewCell() }
       // let row = list[indexPath.row]
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}



extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        // let item = list[indexPath.item]
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
}

