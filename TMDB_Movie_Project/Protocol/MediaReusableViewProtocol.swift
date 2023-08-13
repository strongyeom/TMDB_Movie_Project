//
//  Mediaidentifier.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import UIKit

// identifier 를 VC에 static으로 만들어주지 않고 프로토콜을 이용해서 정의 할 수 있음
protocol MediaReusableViewProtocol {
    static var identifier : String { get }
}

extension UIViewController: MediaReusableViewProtocol {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}

extension MediaTableViewCell: MediaReusableViewProtocol {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}

extension MovieCollectionViewCell : MediaReusableViewProtocol {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }
}

