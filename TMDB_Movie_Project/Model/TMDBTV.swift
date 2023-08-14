//
//  TMDBTV.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

//struct TMDBTV: Codable {
//    var id: Int
//    var thumbnailTitle: String
//    var name: String
//    var releaseDate: String
//    var overview: String
//}

import Foundation

// MARK: - TodosResponse
struct TMDBTV: Codable {
    let page: Int?
    let results: [TMDBResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TMDBResult: Codable {
    let id: Int?
    let name: String?
    let thumbnailTitle: String?
    let overview: String?
    let genreIDS: [Int]?
    let releaseDate: String?
    let starAverage: Double?
    
    // 연산 프로퍼티로만 만들게 되면 구조체에 추가 되는 것이 아니고 단지 계산만 하는 것이기 때문에 활용 할 수 없음
    var poster: String {
        return "https://image.tmdb.org/t/p/w500/" + (thumbnailTitle ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case id, name
        case overview
        case thumbnailTitle = "poster_path"
        case genreIDS = "genre_ids"
        case releaseDate = "first_air_date"
        case starAverage = "vote_average"
    }

}
