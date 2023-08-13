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
    var resultTV: [TMDBTV] = []
    // 영화만
    var resultMovie: [TMDBMovie] = []
    // Detail 한개만
    var mediaModel: Media?
    
    func callTVRequest(completionHanlder: @escaping ([TMDBTV]) -> Void ) {

        let url = "https://api.themoviedb.org/3/trending/tv/week?api_key=\(APIKey.movieKey)&language=ko"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    let thumbnail = "https://image.tmdb.org/t/p/w500/" + item["poster_path"].stringValue
                    let name = item["name"].stringValue
                    let firstRelease = item["first_air_date"].stringValue
                    let overview = item["overview"].stringValue
                    let id = item["id"].intValue
                    
                    let data = TMDBTV(id: id, thumbnailTitle: thumbnail, name: name, releaseDate: firstRelease, overview: overview)
                    self.resultTV.append(data)
                }
                completionHanlder(self.resultTV)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callMovieRequest(completionHandler: @escaping ([TMDBMovie]) -> Void) {
        
        let url = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(APIKey.movieKey)&language=ko"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    let thumbnail = "https://image.tmdb.org/t/p/w500/" + item["poster_path"].stringValue
                    let title = item["title"].stringValue
                    let release = item["release_date"].stringValue
                    let overview = item["overview"].stringValue
                    let id = item["id"].intValue
                    let star = item["vote_average"].doubleValue
                    let data = TMDBMovie(id: id, thumbnailTtle: thumbnail, title: title, releaseDate: release, overview: overview, starRate: star)
                    
                    self.resultMovie.append(data)
                }
                completionHandler(self.resultMovie)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func detailRequest(id: Int, media: MediaEnum, completionHandler: @escaping (Media?) -> Void) {
        let url = "https://api.themoviedb.org/3/\(media.rawValue)/\(id)?api_key=\(APIKey.movieKey)&language=ko"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                switch media {
                case .movie:
                    let thumbnail = "https://image.tmdb.org/t/p/w500/" + json["poster_path"].stringValue
                    let title = json["title"].stringValue
                    let release = json["release_date"].stringValue
                    let overview = json["overview"].stringValue
                    let id = json["id"].intValue
                    let star = json["vote_average"].doubleValue
                        
                    self.mediaModel = Media(id: id, thumbnailTitle: thumbnail, title: title, releaseDate: release, overview: overview, starRate: star, naviTitle: "영화 상세 정보")
                case .tv:
                   
                        let thumbnail = "https://image.tmdb.org/t/p/w500/" + json["poster_path"].stringValue
                        let title = json["name"].stringValue
                        let firstRelease = json["first_air_date"].stringValue
                        let overview = json["overview"].stringValue
                        let id = json["id"].intValue
                        let star = json["vote_average"].doubleValue
                        
                        self.mediaModel = Media(id: id, thumbnailTitle: thumbnail, title: title, releaseDate: firstRelease, overview: overview, starRate: star, naviTitle: "TV 상세 정보")
                    
                }
                print("mediaModel \(self.mediaModel)")
                completionHandler(self.mediaModel)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
