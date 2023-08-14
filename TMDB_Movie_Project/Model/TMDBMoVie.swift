//
//  TMDBMovie.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import Foundation


// MARK: - TodosResponse
struct TMDBMovie: Codable {
    let page: Int?
    let results: [TMDBMovieResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
// MARK: - Result
struct TMDBMovieResult: Codable {
    let id: Int?
    let title: String?
    let overview, thumbnail: String?
    let genreIDS: [Int]?
    let release: String?
    let star: Double?
    
    var poster: String {
        return "https://image.tmdb.org/t/p/w500/" + (thumbnail ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case id, title
        case overview
        case thumbnail = "poster_path"
        case genreIDS = "genre_ids"
        case release = "release_date"
        case star = "vote_average"
    }
}
