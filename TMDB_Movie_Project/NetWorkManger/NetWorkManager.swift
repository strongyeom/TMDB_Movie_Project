//
//  NetWorkManager.swift
//  TMDB_Movie_Project
//
//  Created by 염성필 on 2023/08/13.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManger {
    static let shared = NetworkManger()
    
    private init() { }
    
    var mediaEnum: MediaEnum = .tv
    // TV만
    var resultTV: TMDBTV?
    // 영화만
    var resultMovie: TMDBMovie?
    // Detail 한개만
    var mediaModel: Media?
    
    var witcher: Witcher?
    
    func callTVRequest(seasonsNumber: Int, completionHanlder: @escaping (TMDBTV) -> Void ) {

        
        let url = "https://api.themoviedb.org/3/tv/71912/season/\(seasonsNumber)?api_key=\(APIKey.tmdbKey)&language=ko"
        AF.request(url, method: .get).validate()
            .responseDecodable(of: TMDBTV.self) { response in
                completionHanlder(response.value ?? TMDBTV(page: 0, results: [], totalPages: 0, totalResults: 0))
                
            }
        }
    
    func callSeasonsRequest(seasons: Int) {
        let url = "https://api.themoviedb.org/3/tv/71912/season/\(seasons)?api_key=\(APIKey.tmdbKey)&language=ko"
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Witcher.self) { result in
                guard let result = result.value else { return }
                
                for item in result.episodes {
                    self.callSeasonsEpisodeRequest(seasons: seasons, episode: item.episodeNumber, completionHandler: <#(Witcher?) -> Void#>)
                }
                
            }
    }
    // 한 시즌에 에피소드에 대한 이미들이 담김
    func callSeasonsEpisodeRequest(seasons: Int, episode: Int, completionHandler: @escaping (Witcher?) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/71912/season/\(seasons)/episode\(episode)/images?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Witcher.self) { result in
                
                self.witcher = result.value
                
                
            }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
//    func callMovieRequest(completionHandler: @escaping (TMDBMovie) -> Void) {
//
//        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.movieKey)&language=ko"
//
//        AF.request(url, method: .get).validate()
//            .responseDecodable(of: TMDBMovie.self) { result in
//                completionHandler(result.value ?? TMDBMovie(page: 0, results: [], totalPages: 0, totalResults: 0))
//            }
//
//        }
//
//    func detailRequest(id: Int, media: MediaEnum, completionHandler: @escaping (Media?) -> Void) {
//        let url = "https://api.themoviedb.org/3/\(media.rawValue)/\(id)?api_key=\(APIKey.movieKey)&language=ko"
//
//        AF.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//
//                switch media {
//                case .movie:
//                    let thumbnail = "https://image.tmdb.org/t/p/w500/" + json["poster_path"].stringValue
//                    let title = json["title"].stringValue
//                    let release = json["release_date"].stringValue
//                    let overview = json["overview"].stringValue
//                    let id = json["id"].intValue
//                    let star = json["vote_average"].doubleValue
//
//
//                    self.mediaModel = Media(id: id, thumbnailTitle: thumbnail, title: title, releaseDate: release, overview: overview, starRate: star, naviTitle: "영화 상세 정보")
//                case .tv:
//
//                        let thumbnail = "https://image.tmdb.org/t/p/w500/" + json["poster_path"].stringValue
//                        let title = json["name"].stringValue
//                        let firstRelease = json["first_air_date"].stringValue
//                        let overview = json["overview"].stringValue
//                        let id = json["id"].intValue
//                        let star = json["vote_average"].doubleValue
//
//                        self.mediaModel = Media(id: id, thumbnailTitle: thumbnail, title: title, releaseDate: firstRelease, overview: overview, starRate: star, naviTitle: "TV 상세 정보")
//
//                }
//                print("mediaModel \(self.mediaModel)")
//                completionHandler(self.mediaModel)
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }

}
