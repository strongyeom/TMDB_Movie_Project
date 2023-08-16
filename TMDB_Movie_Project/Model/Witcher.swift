//
//  Witcher.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/17.
//

import Foundation
// MARK: - Witcher
struct Witcher: Codable {
    let episodes: [Episode]
    let name, overview: String
    let posterPath: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case episodes, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

// MARK: - Episode
struct Episode: Codable {
    let episodeNumber: Int
    let name, overview: String
    let seasonNumber: Int
    let stillPath: String

    enum CodingKeys: String, CodingKey {
        case episodeNumber = "episode_number"
        case name, overview
        case seasonNumber = "season_number"
        case stillPath = "still_path"
    }
}
