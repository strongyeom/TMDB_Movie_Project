//
//  TMDBViewController.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/17.
//

import UIKit

enum SectionEnum: Int {
    case firstSection = 0
    case seconSection
}


// 1. 시즌마다 에피소드가 있을텐데 시즌의 갯수를 헤더에 두고, 시즌에 해당하는 에피소드 뿌려주기 



class TMDBViewController: UIViewController {

    @IBOutlet var tmdbCollectionView: UICollectionView!
    var sectionEnum: SectionEnum = .firstSection
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        settingCollectionViewLayout()
    }
    
    func setup() {
        tmdbCollectionView.dataSource = self
        tmdbCollectionView.delegate = self
        
        let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        tmdbCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        let nibHeader = UINib(nibName: HeaderCollectionReusableView.identifier, bundle: nil)
        
        tmdbCollectionView.register(nibHeader, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
    }
    
    func settingCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: width / 4)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        tmdbCollectionView.collectionViewLayout = layout
    }

}

extension TMDBViewController: UICollectionViewDelegate {
    
}

extension TMDBViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
            
            print("indexPath \(indexPath.section)")
            switch SectionEnum(rawValue: indexPath.section) {
                
            case .firstSection:
                header.titleLabel.text = "첫번째"
                
            case .seconSection:
                header.titleLabel.text = "두번째"
            default:
                print("123")
            }
           
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionEnum {
        case .firstSection:
            return 10
        case .seconSection:
            return 20
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
}
