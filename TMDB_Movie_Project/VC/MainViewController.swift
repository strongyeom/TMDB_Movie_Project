//
//  ViewController.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import UIKit
import Alamofire
import SwiftyJSON


class MainViewController: UIViewController {
    
    var movieList: [TMDBMovieResult]?
    var tvList: [TMDBResult]?
    
    var mediaEnum: MediaEnum = .tv
    
    @IBOutlet var movieCollectionView: UICollectionView!
    @IBOutlet var mediaTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavibar()
        setupMovie()
        setupMedia()
        setupNetworkMovie()
        setupNetworkTV()
    }
    
    func setupNavibar() {
        navigationItem.title = "TMDB 데이터"
    }
    
    func setupNetworkMovie() {
        NetworkManger.shared.callMovieRequest { result in
            self.movieList = result.results
            self.movieCollectionView.reloadData()
        }
    }
    
    func setupNetworkTV() {

        NetworkManger.shared.callTVRequest { result in
            self.tvList = result.results
            print("tvList",self.tvList!)
            self.mediaTableView.reloadData()
        }
    }
 
}

// MARK: - TableView
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TV부문"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "영화 부문"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tvList = tvList else { return 0 }
        return tvList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifier, for: indexPath) as? MediaTableViewCell else { return UITableViewCell() }
        guard let tvList else { return UITableViewCell() }
        
        let row = tvList[indexPath.row]
        cell.configure(row: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TableView - \(indexPath.row)")
        guard let tvList else { return }
        let selected = tvList[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        vc.id = selected.id
        vc.media = .tv
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension MainViewController: UITableViewDelegate {
    
}



// MARK: - CollectionView
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movieList = movieList else { return 0}
        return movieList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        guard let movieList else { return UICollectionViewCell() }
        let item = movieList[indexPath.item]
        cell.confiure(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView - \(indexPath.row)")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let movieList else { return }
        let selected = movieList[indexPath.item]
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        vc.id = selected.id
        vc.media = .movie
        vc.title = "영화 상세 정보"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
}


// MARK: - MainVC Setup
extension MainViewController {
    
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
        mediaTableView.separatorStyle = .none
    }

}
